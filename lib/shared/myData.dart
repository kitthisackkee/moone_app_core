import 'package:intl/intl.dart';

class MyData {
  static String id_sale = '';

  static String formatNumber(dynamic numbers) {
    final formatter = NumberFormat('#,###');
    return formatter.format(numbers);
  }
}
