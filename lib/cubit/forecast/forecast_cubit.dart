import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nenda_invfest/data/model/forecast_model.dart';
import 'package:nenda_invfest/services/forecast_service.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit() : super(ForecastInitial());

  void getForecastData(double lat, double lon) async {
    try {
      emit(ForecastLoading());
      ForecastModel data = await ForecastService().getForecastData(lat, lon);
      emit(ForecastSuccess(data));
    } catch (e) {
      emit(ForecastError(e.toString()));
    }
  }
}
