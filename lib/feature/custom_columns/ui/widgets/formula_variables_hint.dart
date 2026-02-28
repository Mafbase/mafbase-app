import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

class FormulaVariablesHint extends StatelessWidget {
  final Function(String variable) onVariableTap;

  const FormulaVariablesHint({super.key, required this.onVariableTap});

  static const _variables = [
    'score',
    'addScore',
    'minusScore',
    'wins',
    'firstDie',
    'ci',
    'totalGames',
    'citizenGames',
    'mafiaGames',
    'donGames',
    'sheriffGames',
    'citizenWins',
    'mafiaWins',
    'donWins',
    'sheriffWins',
    'citizenAddScore',
    'mafiaAddScore',
    'donAddScore',
    'sheriffAddScore',
    'citizenScore',
    'mafiaScore',
    'donScore',
    'sheriffScore',
    'citizenMinusScore',
    'mafiaMinusScore',
    'donMinusScore',
    'sheriffMinusScore',
    'bestMoveCitizen',
    'bestMoveSheriff',
    'refereeCount',
  ];

  static const _functions = [
    'min',
    'max',
    'abs',
    'round',
    'floor',
    'ceil',
  ];

  String _variableTooltip(BuildContext context, String variable) {
    final locale = context.locale;
    return switch (variable) {
      'score' => locale.tooltipScore,
      'addScore' => locale.tooltipAddScore,
      'minusScore' => locale.tooltipMinusScore,
      'wins' => locale.tooltipWins,
      'firstDie' => locale.tooltipFirstDie,
      'ci' => locale.tooltipCi,
      'totalGames' => locale.tooltipTotalGames,
      'citizenGames' => locale.tooltipCitizenGames,
      'mafiaGames' => locale.tooltipMafiaGames,
      'donGames' => locale.tooltipDonGames,
      'sheriffGames' => locale.tooltipSheriffGames,
      'citizenWins' => locale.tooltipCitizenWins,
      'mafiaWins' => locale.tooltipMafiaWins,
      'donWins' => locale.tooltipDonWins,
      'sheriffWins' => locale.tooltipSheriffWins,
      'citizenAddScore' => locale.tooltipCitizenAddScore,
      'mafiaAddScore' => locale.tooltipMafiaAddScore,
      'donAddScore' => locale.tooltipDonAddScore,
      'sheriffAddScore' => locale.tooltipSheriffAddScore,
      'citizenScore' => locale.tooltipCitizenScore,
      'mafiaScore' => locale.tooltipMafiaScore,
      'donScore' => locale.tooltipDonScore,
      'sheriffScore' => locale.tooltipSheriffScore,
      'citizenMinusScore' => locale.tooltipCitizenMinusScore,
      'mafiaMinusScore' => locale.tooltipMafiaMinusScore,
      'donMinusScore' => locale.tooltipDonMinusScore,
      'sheriffMinusScore' => locale.tooltipSheriffMinusScore,
      'bestMoveCitizen' => locale.tooltipBestMoveCitizen,
      'bestMoveSheriff' => locale.tooltipBestMoveSheriff,
      'refereeCount' => locale.tooltipRefereeCount,
      _ => variable,
    };
  }

  String _functionTooltip(BuildContext context, String fn) {
    final locale = context.locale;
    return switch (fn) {
      'min' => locale.tooltipFnMin,
      'max' => locale.tooltipFnMax,
      'abs' => locale.tooltipFnAbs,
      'round' => locale.tooltipFnRound,
      'floor' => locale.tooltipFnFloor,
      'ceil' => locale.tooltipFnCeil,
      _ => fn,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            context.locale.customColumnsAvailableVariables,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: _variables
              .map(
                (variable) => Tooltip(
                  message: _variableTooltip(context, variable),
                  child: ActionChip(
                    label: Text(
                      variable,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                    onPressed: () => onVariableTap(variable),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        Text(
          context.locale.customColumnsOperations,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text('+ - * / ( )'),
        const SizedBox(height: 8),
        Text(
          context.locale.customColumnsFunctions,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: _functions
              .map(
                (fn) => Tooltip(
                  message: _functionTooltip(context, fn),
                  child: ActionChip(
                    label: Text(
                      fn,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                    onPressed: () => onVariableTap(fn),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
