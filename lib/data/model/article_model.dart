class ArticleModel {
  ArticleModel({
    this.articleId,
    this.title,
    this.author,
    this.publishedAt,
    this.description,
    this.backgroundUrl,
  });

  int? articleId;
  String? title;
  String? author;
  String? publishedAt;
  String? description;
  String? backgroundUrl;
}
