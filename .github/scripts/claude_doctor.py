#!/usr/bin/env python3
"""
Claude Workflow Doctor — анализирует логи GitHub Actions через claude CLI
и генерирует отчёт для создания GitHub Issue.
"""

import os
import sys
import json
import subprocess
import tempfile
from datetime import datetime

MAX_LOG_CHARS = 40_000

PROMPT_TEMPLATE = """You are "Claude Workflow Doctor". Analyze these GitHub Actions workflow logs and detect problems.

Workflow: {workflow_name}
Status: {workflow_status}

=== LOGS START ===
{logs}
=== LOGS END ===

## IGNORE these messages (they are known noise, NOT problems):
- "Internal error: directory mismatch for directory ... You don't need to do anything, but this indicates a bug." — this is a known runner-level bug, not actionable.
- "##[warning]Node.js 20 actions are deprecated..." / "Actions will be forced to run with Node.js 24 by default starting ..." — GitHub deprecation notice, not a workflow problem.

Do NOT report these as problems. Skip them entirely.

## Detect these patterns:

**Tool access errors:** "Tool X is not in the list of allowed tools", "not allowed to use tool"
**Circular loops:** same error/action repeated 3+ times, "I will try again" repeated
**Missing CLI tools:** "command not found: gh", "fvm: command not found", "flutter: not found"
**Argument parsing bugs:** PR number passed as repo path, wrong flag combinations
**Permission errors:** "Resource not accessible by integration", "GitHub token does not have"
**API errors:** "overloaded_error", "context_length_exceeded", many "api_retry" events
**Runner issues:** "No runner matching", runner offline

Respond ONLY with valid JSON, no markdown fences:

{{
  "has_problems": true/false,
  "severity": "critical" | "warning" | "info",
  "health_score": 0-100,
  "summary": "Brief diagnosis in Russian (1-2 sentences)",
  "problems": [
    {{
      "type": "tool_access|loop|missing_tool|argument_error|permission|api_error|runner|other",
      "title": "Short title in Russian",
      "description": "Detailed explanation in Russian",
      "evidence": "Exact log fragment (max 200 chars)",
      "fix_description": "What to change in Russian",
      "fix_code": "Concrete YAML/bash/code fix, or null"
    }}
  ]
}}

If no problems: has_problems=false, problems=[], health_score=100."""


SEVERITY_EMOJI = {"critical": "🔴", "warning": "🟡", "info": "🟢"}
TYPE_EMOJI = {
    "tool_access": "🔧", "loop": "🔄", "missing_tool": "❌",
    "argument_error": "⚠️", "permission": "🔒", "api_error": "🌐",
    "runner": "🖥️", "other": "🔍"
}


def set_output(name: str, value: str):
    output_file = os.environ.get("GITHUB_OUTPUT")
    if output_file:
        delimiter = "EOF_DOCTOR"
        with open(output_file, "a") as f:
            f.write(f"{name}<<{delimiter}\n{value}\n{delimiter}\n")
    else:
        print(f"OUTPUT {name}={value}")


def truncate_logs(text: str, max_chars: int) -> str:
    if len(text) <= max_chars:
        return text
    half = max_chars // 2
    return text[:half] + f"\n\n... [TRUNCATED {len(text) - max_chars} chars] ...\n\n" + text[-half:]


def call_claude_cli(prompt: str) -> dict:
    """Вызываем claude CLI с --print флагом (non-interactive)."""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.txt', delete=False) as f:
        f.write(prompt)
        prompt_file = f.name

    try:
        result = subprocess.run(
            [
                "claude",
                "--print",                    # non-interactive, вывод в stdout
                "--output-format", "text",    # plain text ответ
                "--max-turns", "1",           # только один ответ, без диалога
                "--allowedTools", "",         # доктору не нужны инструменты
                f"$(cat {prompt_file})",
            ],
            capture_output=True,
            text=True,
            timeout=120,
            env={**os.environ},
        )

        # claude --print читает prompt из stdin удобнее
        if result.returncode != 0 or not result.stdout.strip():
            # Пробуем через stdin
            result = subprocess.run(
                ["claude", "--print", "--output-format", "text", "--max-turns", "1"],
                input=prompt,
                capture_output=True,
                text=True,
                timeout=120,
                env={**os.environ},
            )

        output = result.stdout.strip()
        if not output:
            raise ValueError(f"Empty response from claude CLI. stderr: {result.stderr[:500]}")

        # Убираем markdown fences если есть
        if output.startswith("```"):
            lines = output.split("\n")
            output = "\n".join(lines[1:-1] if lines[-1] == "```" else lines[1:])

        return json.loads(output)

    finally:
        os.unlink(prompt_file)


def build_issue_body(diagnosis: dict) -> str:
    workflow_name = os.environ.get("WORKFLOW_NAME", "Claude workflow")
    workflow_url = os.environ.get("WORKFLOW_URL", "")
    workflow_status = os.environ.get("WORKFLOW_STATUS", "completed")
    head_branch = os.environ.get("HEAD_BRANCH", "")
    head_sha = os.environ.get("HEAD_SHA", "")
    run_id = os.environ.get("RUN_ID", "")
    pr_number = os.environ.get("PR_NUMBER", "")
    now = datetime.utcnow().strftime("%Y-%m-%d %H:%M UTC")

    sev = diagnosis.get("severity", "warning")
    sev_emoji = SEVERITY_EMOJI.get(sev, "⚠️")
    score = diagnosis.get("health_score", 0)
    problems = diagnosis.get("problems", [])

    score_bar = "█" * int(score / 10) + "░" * (10 - int(score / 10))

    lines = [
        f"## 🩺 Claude Workflow Doctor Report",
        f"",
        f"> **Workflow:** [{workflow_name}]({workflow_url})  ",
        f"> **Status:** `{workflow_status}`  ",
        f"> **Branch:** `{head_branch}`  ",
        f"> **Commit:** `{head_sha[:7] if head_sha else 'n/a'}`  ",
        *([ f"> **PR:** #{pr_number}  " ] if pr_number else []),
        f"> **Scanned:** {now}",
        f"",
        f"---",
        f"",
        f"### {sev_emoji} Severity: `{sev.upper()}` &nbsp;·&nbsp; Health score: `{score}/100`",
        f"",
        f"```",
        f"[{score_bar}] {score}%",
        f"```",
        f"",
        f"**Summary:** {diagnosis.get('summary', '')}",
        f"",
        f"---",
        f"",
        f"### 🔎 Problems Found ({len(problems)})",
        f"",
    ]

    for i, p in enumerate(problems, 1):
        t_emoji = TYPE_EMOJI.get(p.get("type", "other"), "🔍")
        lines += [
            f"<details>",
            f"<summary><b>{t_emoji} #{i} — {p.get('title', '')}</b> &nbsp;<code>{p.get('type', '')}</code></summary>",
            f"",
            f"**Description:**  ",
            f"{p.get('description', '')}",
            f"",
        ]
        evidence = p.get("evidence", "")
        if evidence:
            lines += [
                f"**Evidence from logs:**",
                f"```",
                f"{evidence[:300]}",
                f"```",
                f"",
            ]
        fix_desc = p.get("fix_description", "")
        fix_code = p.get("fix_code")
        if fix_desc:
            lines += [f"**✅ Fix:**  ", f"{fix_desc}", f""]
        if fix_code:
            lang = "yaml" if any(k in fix_code for k in ["runs-on", "steps:", "uses:"]) else "bash"
            lines += [f"```{lang}", f"{fix_code}", f"```", f""]
        lines += ["</details>", ""]

    lines += [
        f"---",
        f"<sub>🤖 Generated by Claude Workflow Doctor · Run ID: {run_id}</sub>",
    ]

    return "\n".join(lines)


def main():
    log_path = "all_logs.txt"
    if not os.path.exists(log_path):
        print("No log file found, skipping")
        set_output("has_problems", "false")
        return

    with open(log_path, "r", errors="replace") as f:
        raw_logs = f.read()

    if not raw_logs.strip():
        print("Empty logs, skipping")
        set_output("has_problems", "false")
        return

    logs = truncate_logs(raw_logs, MAX_LOG_CHARS)
    print(f"Analyzing {len(logs)} chars of logs...")

    prompt = PROMPT_TEMPLATE.format(
        workflow_name=os.environ.get("WORKFLOW_NAME", "unknown"),
        workflow_status=os.environ.get("WORKFLOW_STATUS", "unknown"),
        logs=logs,
    )

    try:
        diagnosis = call_claude_cli(prompt)
    except Exception as e:
        print(f"Doctor error: {e}", file=sys.stderr)
        set_output("has_problems", "false")
        return

    print(f"Diagnosis: {json.dumps(diagnosis, ensure_ascii=False, indent=2)}")

    has_problems = diagnosis.get("has_problems", False)
    severity = diagnosis.get("severity", "info")
    problems = diagnosis.get("problems", [])

    set_output("has_problems", "true" if has_problems else "false")
    set_output("severity", severity)

    if has_problems and problems:
        workflow_name = os.environ.get("WORKFLOW_NAME", "Claude workflow")
        workflow_status = os.environ.get("WORKFLOW_STATUS", "completed")
        sev_emoji = SEVERITY_EMOJI.get(severity, "⚠️")
        n = len(problems)
        title = f"{sev_emoji} [{workflow_name}] Doctor found {n} problem{'s' if n != 1 else ''} ({workflow_status})"
        set_output("issue_title", title)

        body = build_issue_body(diagnosis)
        with open("/tmp/doctor_issue_body.md", "w") as f:
            f.write(body)
        print(f"Issue body written ({len(body)} chars)")
    else:
        print("No problems detected")


if __name__ == "__main__":
    main()