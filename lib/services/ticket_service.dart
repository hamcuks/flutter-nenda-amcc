import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nenda_invfest/data/model/ticket_model.dart';

class TicketService {
  CollectionReference _ticketRef =
      FirebaseFirestore.instance.collection('ticket');
  Future<void> addTicket({required TicketModel data}) {
    try {
      return _ticketRef.add(data.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<TicketModel>> getTickets({required String userId}) async {
    QuerySnapshot _data =
        await _ticketRef.where("user_id", isEqualTo: userId).get();
    try {
      var data = _data.docs
          .map((e) => TicketModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      print(data);
      return data;
    } catch (e) {
      throw e.toString();
    }
  }
}
