class ArticleSourceModel {
  final String? id;
  final String name;

  ArticleSourceModel({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }

  factory ArticleSourceModel.fromJson(Map<String, dynamic> json) {
    return ArticleSourceModel(id: json["id"], name: json["name"]);
  }
}