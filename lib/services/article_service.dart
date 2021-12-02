import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nenda_invfest/data/model/article_model.dart';

class ArticleService {
  CollectionReference _articleRef =
      FirebaseFirestore.instance.collection('artikel');

  Future<List<ArticleModel>> fetchArticles() async {
    try {
      QuerySnapshot _data = await _articleRef.get();

      return _data.docs
          .map((e) => ArticleModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ArticleModel>> fetchPopularArticles() async {
    try {
      QuerySnapshot _data = await _articleRef
          .where('view_count', isGreaterThan: 500)
          .limit(3)
          .get();

      return _data.docs
          .map((e) => ArticleModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
