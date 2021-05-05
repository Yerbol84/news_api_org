import 'package:flutter/material.dart';
import 'package:newsapiapp2/UI/AppTheme.dart';

import 'package:newsapiapp2/models/ArticleModel.dart';
import 'package:newsapiapp2/models/FNewsList.dart';
import 'package:newsapiapp2/pages/ArticleViewPage.dart';
import 'package:newsapiapp2/widget/ArticleImage.dart';
import 'package:provider/provider.dart';

class BlogTile extends StatefulWidget {
  final ArticleModel articleModel;
  BlogTile({required this.articleModel});

  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  late FNewsList fNewsList;

  @override
  void initState() {
    fNewsList = Provider.of<FNewsList>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ArticleViewPage(articleModel: widget.articleModel),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(children: [
          ArticleImage(url: widget.articleModel.urlImage),
          Text(widget.articleModel.title, style: articleTitleTextStyle),
          SizedBox(height: 8),
          Row(children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.83,
                child: Text(widget.articleModel.description,
                    style: articleDescriptionTextStyle)),
            IconButton(
                icon: Icon(fNewsList.isFavorite(widget.articleModel)
                    ? Icons.star
                    : Icons.star_border),
                onPressed: () {
                  if (fNewsList.isFavorite(widget.articleModel))
                    fNewsList.remove(fNewsList.list
                        .where(
                            (element) => element.url == widget.articleModel.url)
                        .first);
                  else
                    fNewsList.add(widget.articleModel);
                  setState(() {});
                })
          ]),
        ]),
      ),
    );
  }
}
