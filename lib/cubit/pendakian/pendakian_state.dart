part of 'pendakian_cubit.dart';

abstract class PendakianState extends Equatable {
  const PendakianState();

  @override
  List<Object> get props => [];
}

class PendakianInitial extends PendakianState {}

class PendakianLoading extends PendakianState {}

class PendakianSuccess extends PendakianState {
  final List<PendakianModel> pendakian;

  PendakianSuccess(this.pendakian);

  @override
  List<Object> get props => [pendakian];
}

class PendakianError extends PendakianState {
  final String errorMessage;

  PendakianError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
