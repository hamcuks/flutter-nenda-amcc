part of 'article_cubit.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleSuccess extends ArticleState {
  final List<ArticleModel>? articles;
  final List<ArticleModel>? searchArticles;

  ArticleSuccess({this.articles, this.searchArticles});
}

class ArticleError extends ArticleState {
  final String errorMessage;

  ArticleError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
