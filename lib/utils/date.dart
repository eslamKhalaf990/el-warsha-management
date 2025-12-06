import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate1 (String date){

    return DateFormat('MMMM').format(
        DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(date)
    );
  }

  static String formatDate2(String date) {

    final parsed = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(date);
    return DateFormat('EEE, d MMM yy hh:mm a').format(parsed);
  }

  static String formatDatePicker (String date){

    return DateFormat('EEE, d MMM yyyy')
        .format(DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(date));
  }

  static String formatNotificationTime (String time){

    if(time == "00:00:00") return "--";
    return DateFormat('EEE, d MMM yyyy').format(DateFormat('yyyy-M-dd hh:mm:ss').parse(time));
  }

  static String formatDateMY (String date){

    return DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(date));
  }

  static String formatTime1 (String time){

    if(time == "00:00:00") return "--";
    return DateFormat('d MMM yyyy, hh:mm a').format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(time));
  }

  static String formatTime2 (String time){

    if(time == "00:00:00") return "--";
    return DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(time));
  }

  static String formatTime(String time) {

    if (time == "00:00:00" || time.startsWith("1900-01-01T00:00:00")) {
      return "--";
    }

    final parsedTime = DateTime.parse(time);
    return DateFormat('hh:mm a').format(parsedTime);
  }

}