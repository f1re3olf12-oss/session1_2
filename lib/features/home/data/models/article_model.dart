import 'package:session1_2/features/home/data/models/article_source_model.dart';

class ArticleModel {
  final ArticleSourceModel source;
  final String author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content;

  ArticleModel({
    required this.url,
    required this.title,
    required this.source,
    required this.author,
    required this.content,
    required this.urlToImage,
    required this.description,
    required this.publishedAt,
  });
  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "title": title,
      "source": source.toJson(),
      "author": author,
      "content": content,
      "urlToImage": urlToImage,
      "description": description,
      "publishedAt": publishedAt,
    };
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      url: json["url"],
      title: json["title"] ?? "No title found",
      author: json["author"] ?? "No author found",
      content: json["content"] ?? "No content found",
      urlToImage: json["urlToImage"] ?? "No image url found",
      description: json["description"] ?? "No description found",
      publishedAt: json["publishedAt"],
      source: ArticleSourceModel.fromJson(json["source"]),
    );
  }
}
