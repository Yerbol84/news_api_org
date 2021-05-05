import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapiapp2/models/ArticleModel.dart';
import 'package:newsapiapp2/models/NewsListModel.dart';

const NEWS_API_KEY = "75d202c02bf44bceb432d250edf5fccc";
const BASE_URL = 'newsapi.org';

class ArticleRepository {
  static Future<List<ArticleModel>> fetchArticle(
      NewsListModel newsListModel) async {
    if (newsListModel.totalPages < newsListModel.page) return [];
    Map<String, String> param = {};
    switch (newsListModel.ep) {
      case '/v2/top-headlines':
        param = {
          'pageSize': newsListModel.pageSize.toString(),
          'page': newsListModel.page.toString(),
          'country': "ru",
          "apiKey": NEWS_API_KEY,
          'q': newsListModel.q,
        };
        break;
      case '/v2/everything':
        param = {
          'pageSize': newsListModel.pageSize.toString(),
          'page': newsListModel.page.toString(),
          "apiKey": NEWS_API_KEY,
          'q': newsListModel.q.isEmpty ? "Today" : newsListModel.q,
          'language': 'ru',
        };
        break;
    }
    if (newsListModel.totalPages >= newsListModel.page) {
      Uri uri = Uri.https(BASE_URL, newsListModel.ep, param);
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map articlesMap = JsonCodec().decode(response.body);
        return newsListModel.fromMap(articlesMap);
      } else {
        throw Exception('Failed to load articles, status code: ' +
            response.statusCode.toString());
      }
    }
    return newsListModel.articles;
  }
}
