import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  /// Путь, на который нужно вернуться после завершения оплаты. Передаётся явно, а не
  /// извлекается из query-параметров финального редиректа платёжного провайдера,
  /// так как он не гарантированно сохраняет кастомные параметры.
  final String? nextPath;
  final int? purchaseId;

  const WebViewScreen({
    super.key,
    @QueryParam('title') this.title = '',
    @QueryParam('url') this.url = '',
    @QueryParam('nextPath') this.nextPath,
    @QueryParam('purchaseId') this.purchaseId,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  double progress = 1;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Scaffold(
      backgroundColor: theme.background1,
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
                final nextPath = widget.nextPath;
                final purchaseId = widget.purchaseId;
                if (nextPath != null) {
                  context.router.navigatePath(
                    '/payment-waiting?nextPath=${Uri.encodeQueryComponent(nextPath)}'
                    '${purchaseId != null ? '&purchaseId=$purchaseId' : ''}',
                  );
                } else {
                  context.router.navigatePath(
                    url.hasFragment ? url.fragment : '${url.path}?${url.query}',
                  );
                }
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
            Container(
              color: theme.background1,
              child: Center(
                child: CircularProgressIndicator(
                  value: progress == 0 ? null : progress,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
