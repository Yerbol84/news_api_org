import 'package:flutter/material.dart';
import 'package:newsapiapp2/models/ArticleModel.dart';
import 'package:newsapiapp2/models/NewsListModel.dart';
import 'package:newsapiapp2/pages/NewsListWidget.dart';
import 'package:newsapiapp2/repo/ArticleRepositoryImpl.dart';

class NewsPage extends StatefulWidget {
  final String ep;
  final String q;
  NewsPage({required this.ep, required this.q});
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsListModel newsListModel;

  @override
  void initState() {
    newsListModel = NewsListModel(ep: widget.ep);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: ArticleRepository.fetchArticle(newsListModel).then((_) {
        newsListModel.page++;
        return _;
      }),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text("Error");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            return NewsListWidget(
              newsListModel: newsListModel,
            );
          default:
            return Text('Default');
        }
      },
    );
  }
}
