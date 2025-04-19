import 'package:intl/intl.dart';

class AppConstants {
  AppConstants._();
  static String formatTime(String time) {
    final parsedTime = DateFormat.Hms().parse(time);
    return DateFormat.Hm().format(parsedTime);
  }
}
