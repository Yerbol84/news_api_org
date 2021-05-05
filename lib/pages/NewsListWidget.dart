import 'package:flutter/material.dart';
import 'package:newsapiapp2/models/NewsListModel.dart';

import 'package:newsapiapp2/pages/BlogTile.dart';
import 'package:newsapiapp2/repo/ArticleRepositoryImpl.dart';
import 'package:async/async.dart';

class NewsListWidget extends StatefulWidget {
  final NewsListModel newsListModel;
  NewsListWidget({required this.newsListModel});
  @override
  _NewsListWidgetState createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  ScrollController sc = ScrollController();
  late NewsListModel nlm;
  CancelableOperation? co;

  @override
  void initState() {
    nlm = widget.newsListModel;
    super.initState();
  }

  @override
  void dispose() {
    if (co != null) co!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: onNotif,
        child: ListView.builder(
            controller: sc,
            itemCount: nlm.articles.length,
            itemBuilder: (context, index) =>
                BlogTile(articleModel: nlm.articles[index])));
  }

  bool onNotif(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      if (sc.position.maxScrollExtent <= sc.offset) {
        if (nlm.totalPages >= nlm.page) {
          co = CancelableOperation.fromFuture(
              ArticleRepository.fetchArticle(nlm).then((nextPage) {
            setState(() {
              nlm.page++;
            });
          }));
        }
      }
      return true;
    } else
      return false;
  }
}
