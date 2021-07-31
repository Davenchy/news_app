import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewArticleScreen extends StatelessWidget {
  const ViewArticleScreen(this.url, {Key? key}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
