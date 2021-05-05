import 'package:flutter/material.dart';

const String IMAGE_BASE_URL =
    "https://i.pinimg.com/originals/59/76/b4/5976b43e42a0c62828dbe0317032074a.png";

class ArticleImage extends StatelessWidget {
  final String url;
  ArticleImage({required this.url});
  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        child = ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(url),
        );
        if (loadingProgress == null) {
          print(url);
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.network(IMAGE_BASE_URL);
      },
    );
  }
}
