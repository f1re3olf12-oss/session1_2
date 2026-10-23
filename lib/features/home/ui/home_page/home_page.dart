import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:session1_2/features/home/data/home_repo.dart';
import 'package:session1_2/features/home/data/models/api_result.dart';
import 'package:session1_2/features/home/data/models/article_model.dart';
import 'package:session1_2/features/home/data/models/article_widget.dart';
import 'package:session1_2/features/home/data/models/category_model.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  String category = "sports";
  String failureMessage = "";
  List<ArticleModel> articles = [];
  List<CategoryModel> tabs = [
    CategoryModel(title: "sport", icon: Icons.sports),
    CategoryModel(title: "Top news", icon: Icons.feed),
    CategoryModel(title: "Science", icon: Icons.science),
    CategoryModel(title: "business", icon: Icons.business),
    CategoryModel(title: "Technology", icon: Icons.laptop),
    CategoryModel(title: "Health", icon: Icons.health_and_safety),
  ];
  void fetchArticles() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    ApiResult<List<ArticleModel>> result = await HomeRepo().getArticles(
      category,
      page: 1,
      pageSize: 10,
    );
    if (result is ApiSuccess<List<ArticleModel>>) {
      setState(() {
        articles.clear();
        articles.addAll(result.data);
        isLoading = false;
      });
    } else {
      setState(() {
        failureMessage = (result as ApiFailure<List<ArticleModel>>).message;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchArticles();

    // HomeRepo().getArticles(category); // => return success or failure
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Icon(Icons.menu, color: Colors.white, size: 18),
          title: Text(
            "Easy News",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: .w600,
            ),
          ),
          actions: [Icon(Icons.search, color: Colors.white, size: 18)],
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            onTap: (index) {
              setState(() {
                category = tabs[index].title.toLowerCase();
              });
              fetchArticles();
            },
            tabs: tabs
                .map(
                  (category) => Column(
                    children: [Icon(category.icon), Text(category.title)],
                  ),
                )
                .toList(),
          ),
        ),
        body: isLoading
            ? Center(
                child: LoadingAnimationWidget.threeRotatingDots(
                  color: Colors.black,
                  size: 20,
                ),
              )
            : failureMessage.isNotEmpty
            ? Center(child: Text(failureMessage))
            : TabBarView(
                children: tabs.map((_) {
                  return ListView.separated(
                    itemBuilder: (_, index) {
                      return ArticleWidget(article: articles[index]);
                    },
                    separatorBuilder: (_, _) {
                      return SizedBox(height: 10);
                    },
                    itemCount: articles.length,
                  );
                }).toList(),
              ),
      ),
    );
  }
}
