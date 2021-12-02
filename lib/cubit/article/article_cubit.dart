import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nenda_invfest/data/model/article_model.dart';
import 'package:nenda_invfest/services/article_service.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial()) {
    fetchArticles();
  }

  List<ArticleModel> _articles = [];

  void fetchArticles() async {
    try {
      emit(ArticleLoading());
      _articles = await ArticleService().fetchArticles();
      emit(ArticleSuccess(articles: _articles));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }

  void searchArtikel(String keyword) async {
    try {
      emit(ArticleLoading());
      List<ArticleModel> _filteredArticles = _articles
          .where((e) =>
              e.title!.toLowerCase().contains(keyword.toLowerCase()) ||
              e.author!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      emit(ArticleSuccess(
          articles: _articles, searchArticles: _filteredArticles));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}
