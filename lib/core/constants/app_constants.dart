import 'package:intl/intl.dart';

class AppConstants {
  AppConstants._();
  static String formatTime(String time) {
    final parsedTime = DateFormat.Hms().parse(time);
    return DateFormat.Hm().format(parsedTime);
  }

  static String extractFormattedDateRange(String rentalPeriod) {
    try {
      final parts = rentalPeriod.split('→');
      if (parts.length != 2) return rentalPeriod;

      final startRaw = parts[0].trim();
      final endRaw = parts[1].trim();

      final now = DateTime.now();
      final currentYear = now.year;

      final start = DateFormat("d MMM h:mm a", "en_US").parse("$startRaw");
      final end = DateFormat("d MMM h:mm a", "en_US").parse("$endRaw");

      final startWithYear = DateTime(currentYear, start.month, start.day);
      final endWithYear = DateTime(currentYear, end.month, end.day);

      final startFormatted = DateFormat("dd-MM-yyyy").format(startWithYear);
      final endFormatted = DateFormat("dd-MM-yyyy").format(endWithYear);

      return "$startFormatted au $endFormatted";
    } catch (e) {
      return "Date : $rentalPeriod";
    }
  }

  static int calculateRentalDays(String rentalPeriod) {
    try {
      final parts = rentalPeriod.split('→');
      if (parts.length != 2) return 0;

      final startRaw = parts[0].trim();
      final endRaw = parts[1].trim();

      final now = DateTime.now();
      final year = now.year;

      final start = DateFormat("d MMM h:mm a", "en_US").parse(startRaw);
      final end = DateFormat("d MMM h:mm a", "en_US").parse(endRaw);

      // Ajoute l'année manquante
      final startWithYear = DateTime(year, start.month, start.day);
      final endWithYear = DateTime(year, end.month, end.day);

      final diff = endWithYear.difference(startWithYear).inDays + 1;
      return diff;
    } catch (e) {
      return 0;
    }
  }
}
