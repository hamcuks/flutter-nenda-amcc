part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object?> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageSuccess extends HomePageState {
  final List<Pendakian> listOfPendakian;

  HomePageSuccess(this.listOfPendakian);

  @override
  List<Object?> get props => [listOfPendakian];
}

class HomePageError extends HomePageState {
  final String errorMessage;

  HomePageError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
