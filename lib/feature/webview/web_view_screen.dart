import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class WebViewScreen extends StatefulWidget {
  @QueryParam('title')
  final String title;
  @QueryParam('url')
  final String url;

  const WebViewScreen({
    super.key,
    this.title = '',
    required this.url,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
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
                  this.progress = progress / 100;
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
                  context.router.navigateNamed(
                    url.hasFragment ? url.fragment : '${url.path}?${url.query}',
                  );
                  return NavigationActionPolicy.CANCEL;
                }

                if (!const {'http', 'https'}.contains(url?.scheme)) {
                  launchUrlString(
                    url.toString(),
                    mode: LaunchMode.externalApplication,
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
