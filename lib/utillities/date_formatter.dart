import 'package:intl/intl.dart';

class DateFormatter {
  static String getDate(String date) {
    return DateFormat('dd MMMM yyyy').format(DateTime.parse(date));
  }

  static String getTime(String date) {
    return DateFormat('hh:mm').format(DateTime.parse(date));
  }
}
