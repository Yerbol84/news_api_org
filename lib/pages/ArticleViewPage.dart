import 'package:flutter/material.dart';
import 'dart:async';
import 'package:newsapiapp2/models/ArticleModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleViewPage extends StatelessWidget {
  final ArticleModel articleModel;
  ArticleViewPage({required this.articleModel});

  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(articleModel.title),
        ),
        body: WebView(
          initialUrl: articleModel.url,
          onWebViewCreated: (WebViewController wVC) {
            _completer.complete(wVC);
          },
        ));
  }
}
