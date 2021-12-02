part of 'ticket_cubit.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketSuccess extends TicketState {
  final List<TicketModel>? tickets;

  TicketSuccess({this.tickets});
}

class TicketError extends TicketState {
  final String errorMessage;

  TicketError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
