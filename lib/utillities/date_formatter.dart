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
}
