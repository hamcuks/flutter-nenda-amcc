import 'package:intl/intl.dart';

int getCelcius(dynamic kelvin) {
  return (kelvin - 273).round();
}

List<String> getFormattedDate(int timeStamps) {
  final DateTime dateData =
      DateTime.fromMillisecondsSinceEpoch(timeStamps * 1000);
  return DateFormat.yMd('en_US').add_jm().format(dateData).split(" ");
}
