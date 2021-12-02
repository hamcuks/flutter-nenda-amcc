import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nenda_invfest/data/model/pendakian_model.dart';

class PendakianService {
  CollectionReference _pendakianRef =
      FirebaseFirestore.instance.collection('pendakian');

  Future<List<PendakianModel>> fetchPendakian() async {
    try {
      QuerySnapshot _data = await _pendakianRef.get();

      return _data.docs
          .map((e) => PendakianModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<PendakianModel>> fetchPopularPendakian() async {
    try {
      QuerySnapshot _data = await _pendakianRef
          .where('rating', isGreaterThanOrEqualTo: 4.5)
          .orderBy('rating', descending: true)
          .get();

      return _data.docs
          .map((e) => PendakianModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
