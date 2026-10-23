import 'package:dio/dio.dart';
import 'package:session1_2/features/home/data/models/api_result.dart';
import 'package:session1_2/features/home/data/models/article_model.dart';

class HomeRepo {
  final Dio dio = Dio();
  Future<ApiResult<List<ArticleModel>>> getArticles(
    String category, {
    required int pageSize,
    required int page,
  }) async {
    try {
      final Response response = await dio.get(
        "https://newsapi.org/v2/top-headlines",
        queryParameters: {
          "page": page,
          "country": "us",
          "category": category,
          "pageSize": pageSize,
          "apiKey": "25093961168a4bfaa13e81d7a43697ef",
        },
      );
      List<ArticleModel> articles = (response.data["articles"] as List)
          .map((article) => ArticleModel.fromJson(article))
          .toList();
      return ApiSuccess(articles);
    } on DioException catch (exception) {
      return ApiFailure(exception.message.toString());
    } catch (exception) {
      return ApiFailure(exception.toString());
    }
  }
}
