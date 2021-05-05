import 'ArticleModel.dart';

class NewsListModel {
  int page = 1;
  final int pageSize = 20;
  int? totalResults;
  int totalPages = 1;
  late final String ep;
  String q = "";

  List<ArticleModel> articles = [];

  NewsListModel({required this.ep});

  List<ArticleModel> fromMap(Map<dynamic, dynamic> value) {
    if (this.totalResults == null) {
      this.totalResults = int.parse(value["totalResults"].toString());
      double total =
          int.parse(value["totalResults"].toString()) / this.pageSize;
      this.totalPages = total.ceil();
    }

    List<ArticleModel> newList = List<ArticleModel>.from(
        value['articles'].map((article) => ArticleModel.fromJson(article)));
    newList.removeWhere((element) => element.url == "null");
    newList.removeWhere(
        (element1) => articles.any((element2) => element2.url == element1.url));
    articles.addAll(newList);
    return this.articles;
  }

  set queryWord(String word) {
    this.q = word;
  }

  Map<String, String> get getParameters {
    return {
      'page': this.page.toString(),
      'pageSize': this.pageSize.toString(),
      'q': this.q
    };
  }
}
