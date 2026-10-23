import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:session1_2/features/home/data/models/article_model.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleModel article;
  const new({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(article.url));
      },
      child: Container(
        padding: .all(10),
        margin: .all(12),
        decoration: BoxDecoration(
          border: .all(color: Colors.black, width: 1),
          borderRadius: .circular(24),
        ),
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: .circular(24),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage,
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, color: Colors.black, size: 20),
                    placeholder: (context, url) => Center(
                      child: LoadingAnimationWidget.threeRotatingDots(
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              article.title,
              maxLines: 2,
              overflow: .ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: .bold,
                color: Colors.black,
              ),
            ),
            Text(
              article.description,
              maxLines: 2,
              overflow: .ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: .bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Author${article.author}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: .bold,
                color: Colors.white.withAlpha(100),
              ),
            ),
            Text(
              "source :${article.source.name}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: .bold,
                color: Colors.white.withAlpha(100),
              ),
            ),
            Text(
              "Published at :${article.publishedAt}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: .bold,
                color: Colors.white.withAlpha(100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
