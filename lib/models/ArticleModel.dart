enum ArticleLoadMoreStatus { LOADING, STABLE }

class ArticleModel {
  String author;
  String title;
  String description;
  String url;
  String urlImage;
  String content;
  String publishedAt;

  ArticleModel({
    required this.author,
    required this.title,
    required this.content,
    required this.description,
    required this.url,
    required this.urlImage,
    required this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        author: json['author'].toString(),
        title: json['title'].toString(),
        description: json['description'].toString(),
        url: json['url'].toString(),
        urlImage: json['urlToImage'].toString(),
        content: json['content'].toString(),
        publishedAt: json['publishedAt'].toString());
  }
}
