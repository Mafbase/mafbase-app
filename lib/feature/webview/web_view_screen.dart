import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({
    super.key,
    @QueryParam('title') this.title = '',
    @QueryParam('url') this.url = '',
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  double progress = 0;
  bool loading = true;
  bool firstPageLoaded = false;

  double? get progressValue => progress == 0 ? null : progress;

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
                  firstPageLoaded = true;
                });
              },
              onLoadStart: (controller, uri) {
                setState(() {
                  loading = true;
                  progress = 0;
                });
              },
              shouldOverrideUrlLoading: (controller, action) async {
                final url = action.request.url;
                if (url != null && url.host == 'mafbase.ru') {
                  context.router
                    ..removeLast()
                    ..navigatePath(url.hasFragment ? url.fragment : '${url.path}?${url.query}');
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
            if (!firstPageLoaded)
              Positioned.fill(
                child: ColoredBox(
                  color: MyTheme.of(context).background1,
                  child: Center(
                    child: CircularProgressIndicator(value: progressValue),
                  ),
                ),
              )
            else if (loading)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(value: progressValue),
              ),
          ],
        ),
      );
}
