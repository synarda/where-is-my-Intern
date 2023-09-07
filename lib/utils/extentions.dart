import 'package:intl/intl.dart';

class Parsers {
  static String dateTo(DateTime? date) {
    final formatter = DateFormat("dd-MM-yyyy");
    return formatter.format(date ?? DateTime.now());
  }
}
