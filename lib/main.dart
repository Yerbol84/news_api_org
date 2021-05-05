import 'package:flutter/material.dart';

import 'package:newsapiapp2/models/FNewsList.dart';

import 'package:newsapiapp2/pages/FavoritNewsPage.dart';
import 'package:newsapiapp2/pages/NewsPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<FNewsList>(
      create: (context) => FNewsList(),
      child: MaterialApp(
        title: 'News API App',
        home: MyHomePage(title: 'News App'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.all_inclusive)),
            Tab(icon: Icon(Icons.star))
          ]),
        ),
        body: TabBarView(children: [
          NewsPage(ep: "/v2/top-headlines", q: ''),
          NewsPage(ep: "/v2/everything", q: 'Today'),
          FavoritNewsPage()
        ]),
      ),
    );
  }
}
