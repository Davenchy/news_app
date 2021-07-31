import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewArticleScreen extends StatefulWidget {
  const ViewArticleScreen(this.url, {Key? key}) : super(key: key);
  final String url;

  @override
  _ViewArticleScreenState createState() => _ViewArticleScreenState();
}

class _ViewArticleScreenState extends State<ViewArticleScreen> {
  bool showIndicator = false;
  double? indicatorProgress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: showIndicator
            ? PreferredSize(
                child: LinearProgressIndicator(
                  value: indicatorProgress,
                ),
                preferredSize: const Size.fromHeight(10),
              )
            : null,
      ),
      body: WebView(
        initialUrl: widget.url,
        onProgress: (int progress) {
          setState(() {
            indicatorProgress = progress / 100;
          });
        },
        onPageStarted: (String thing) {
          setState(() {
            showIndicator = true;
          });
        },
        onPageFinished: (String thing) {
          setState(() {
            showIndicator = false;
          });
        },
      ),
    );
  }
}
