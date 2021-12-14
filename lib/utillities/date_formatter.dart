import 'package:intl/intl.dart';

class DateFormatter {
  static String getDate(String date) {
    return DateFormat('dd MMMM yyyy').format(DateTime.parse(date).toLocal());
  }

  static String getTime(String date) {
    return DateFormat('HH:mm').format(DateTime.parse(date).toLocal());
  }

  static String getDateTime(String dateTime) {
    return DateFormat('dd MMMM yyyy HH:mm')
        .format(DateTime.parse(dateTime).toLocal());
  }

  static int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
