import 'package:equatable/equatable.dart';

class ArticleModel extends Equatable {
  ArticleModel(
      {this.id,
      this.title,
      this.author,
      this.publishedAt,
      this.description,
      this.imagePath,
      this.viewCount});

  final String? id;
  final String? title;
  final String? author;
  final String? publishedAt;
  final String? description;
  final String? imagePath;
  final int? viewCount;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['id'] == null ? '' : json['id'],
        title: json['title'] == null ? '' : json['title'],
        author: json['author'] == null ? '' : json['author'],
        publishedAt: json['published_at'] == null ? '' : json['published_at'],
        description: json['description'] == null ? '' : json['description'],
        imagePath: json['image_path'] == null ? '' : json['image_path'],
        viewCount: json['view_count'] == null ? '' : json['view_count'],
      );

  @override
  List<Object?> get props =>
      [id, title, author, publishedAt, description, imagePath, viewCount];
}
