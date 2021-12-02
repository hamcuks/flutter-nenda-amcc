part of 'forecast_cubit.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();

  @override
  List<Object> get props => [];
}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastSuccess extends ForecastState {
  final ForecastModel data;
  ForecastSuccess(this.data);
  @override
  List<Object> get props => [data];
}

class ForecastError extends ForecastState {
  final String errorMessage;

  ForecastError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
