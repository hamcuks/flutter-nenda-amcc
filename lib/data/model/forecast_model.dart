class ForecastModel {
  double? lat;
  double? lon;
  CurrentWeather? current;
  List<Hourly>? hourly;
  List<Daily>? daily;

  ForecastModel({
    this.lat,
    this.lon,
    this.current,
    this.hourly,
    this.daily,
  });

  ForecastModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    current = json['current'] != null
        ? new CurrentWeather.fromJson(json['current'])
        : null;
    hourly = json['hourly'] != null
        ? List<Hourly>.from(json['hourly'].map((x) => Hourly.fromJson(x)))
        : <Hourly>[];
    daily = json['daily'] != null
        ? List<Daily>.from(json['daily'].map((x) => Daily.fromJson(x)))
        : <Daily>[];
  }
}

class CurrentWeather {
  int? dt;
  dynamic temp;
  List<Weather>? weather;

  CurrentWeather({
    this.dt,
    this.weather,
  });

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'] as double;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather?.add(new Weather.fromJson(v));
      });
    }
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Hourly {
  int? dt;
  dynamic temp;
  List<Weather>? weather;

  Hourly({
    this.dt,
    this.temp,
    this.weather,
  });

  Hourly.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather?.add(new Weather.fromJson(v));
      });
    }
  }
}

class Daily {
  int? dt;
  Temp? temp;
  List<Weather>? weather;

  Daily({
    this.dt,
    this.temp,
    this.weather,
  });

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'] != null ? new Temp.fromJson(json['temp']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather?.add(new Weather.fromJson(v));
      });
    }
  }
}

class Temp {
  dynamic day;
  dynamic min;
  dynamic max;
  dynamic night;
  dynamic eve;
  dynamic morn;

  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
}
