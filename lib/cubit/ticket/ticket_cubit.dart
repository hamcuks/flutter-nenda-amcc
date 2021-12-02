import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nenda_invfest/data/model/ticket_model.dart';
import 'package:nenda_invfest/services/ticket_service.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit() : super(TicketInitial());

  void createTicket({required TicketModel data}) async {
    try {
      emit(TicketLoading());
      await TicketService().addTicket(data: data);
      emit(TicketSuccess());
    } catch (e) {
      emit(TicketError(e.toString()));
    }
  }

  void getTickets({required String userId}) async {
    try {
      emit(TicketLoading());
      List<TicketModel> _data =
          await TicketService().getTickets(userId: userId);
      emit(TicketSuccess(tickets: _data));
    } catch (e) {
      emit(TicketError(e.toString()));
    }
  }
}
