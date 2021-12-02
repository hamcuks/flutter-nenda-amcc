import 'package:dio/dio.dart';
import 'package:nenda_invfest/data/model/forecast_model.dart';

class ForecastService {
  static const String BASE_URL = 'https://api.openweathermap.org/data/2.5';
  static const String APP_ID = '1582c10165ac6f7afcd75ad297979cd6';

  Dio d = Dio();

  Future<ForecastModel> getForecastData(double lat, double lon) async {
    try {
      Response response = await d.get(
          '$BASE_URL/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$APP_ID');

      ForecastModel? data;

      if (response.statusCode == 200) {
        data = ForecastModel.fromJson(response.data);
      }

      return data!;
    } catch (e) {
      throw e.toString();
    }
  }
}
