import 'package:intl/intl.dart';

class TimeUtil {
  static String getDate(int time) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return DateFormat('yyyy/MM/dd HH:mm:ss').format(dateTime);
  }
}
