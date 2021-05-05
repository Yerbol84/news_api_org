import 'package:flutter/material.dart';
import 'package:newsapiapp2/models/FNewsList.dart';
import 'package:newsapiapp2/pages/BlogTile.dart';
import 'package:provider/provider.dart';

class FavoritNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: Provider.of<FNewsList>(context, listen: false).list.length,
          itemBuilder: (context, index) => BlogTile(
              articleModel:
                  Provider.of<FNewsList>(context, listen: false).list[index]),
        ),
      ),
    );
  }
}
