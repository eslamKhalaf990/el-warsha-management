import 'package:intl/intl.dart';

class PriceHelper {
  static String formatNumber(double value) {
    if(value == 0.0) return "0.0";
    final formatter = NumberFormat('#,###.00');
    return formatter.format(value);
  }
}