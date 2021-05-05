import 'package:flutter/cupertino.dart';
import 'package:newsapiapp2/models/ArticleModel.dart';

class FNewsList with ChangeNotifier {
  List<ArticleModel> list = [];

  add(ArticleModel articleModel) {
    list.add(articleModel);
    notifyListeners();
  }

  remove(ArticleModel articleModel) {
    list.removeWhere((element) => element == articleModel);
    notifyListeners();
  }

  bool isFavorite(ArticleModel articleModel) {
    return list.any((element) => element.url == articleModel.url);
  }
}
