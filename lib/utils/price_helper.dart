import 'package:intl/intl.dart';

class PriceHelper {
  static String formatNumber(double value) {
    final formatter = NumberFormat('#,###');
    return formatter.format(value);
  }
}