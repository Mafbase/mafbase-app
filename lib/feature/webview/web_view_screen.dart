import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();

  static const _name = 'webview';

  static final route = GoRoute(
    name: _name,
    path: '/web-view',
    builder: (context, state) {
      final title = state.uri.queryParameters['title'] ?? '';
      final url = state.uri.queryParameters['url']!;

      return WebViewScreen(
        title: title,
        url: url,
      );
    },
  );

  static String createLocation({
    BuildContext? context,
    GoRouterState? state,
    required String url,
    required String title,
  }) {
    final namedLocation = state?.namedLocation ?? context?.namedLocation;
    if (namedLocation == null) {
      throw Exception('No named location provided');
    }

    return namedLocation(
      _name,
      queryParameters: {
        'title': title,
        'url': url,
      },
    );
  }
}

class _WebViewScreenState extends State<WebViewScreen> {
  double progress = 1;
  bool loading = true;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(widget.url)),
            ),

            onProgressChanged: (controller, progress) {
              setState(() {
                this.progress = progress/100;
              });
            },
            onLoadStop: (controller, uri) {
              setState(() {
                loading = false;
              });
            },
            onLoadStart: (controller, uri) {
              setState(() {
                loading = true;
              });
            },
            shouldOverrideUrlLoading: (controller, action) async {
              final url = action.request.url;
              if (url != null && url.host == 'mafbase.ru') {
                context.go(
                  url.hasFragment ? url.fragment : '${url.path}?${url.query}',
                );
                return NavigationActionPolicy.CANCEL;
              }

              return NavigationActionPolicy.ALLOW;
            },
          ),
          if (loading)
            LoadingOverlayWidget(
              value: progress == 0 ? null : progress,
            ),
        ],
      ),
    );
}
