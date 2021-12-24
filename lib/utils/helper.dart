import 'package:intl/intl.dart';

class Helper {
  static String formatDateTime(String dateTime) {
    var formatter = DateFormat('MMM dd, yyyy');
    var formatter2 = DateFormat('hh:mm a');
    DateTime dt = DateTime.parse(dateTime);
    if (dt.day == DateTime.now().day) {
      return formatter2.format(dt);
    } else {
      return formatter.format(dt);
    }
  }

  static String formatDateTimeAndDisplayWithTime(String dateTime) {
    var formatter = DateFormat('MMMM dd, yyyy hh:mm a');
    DateTime dt = DateTime.parse(dateTime);
    return formatter.format(dt);
  }
}
