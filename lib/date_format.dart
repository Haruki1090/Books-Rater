import 'package:intl/intl.dart';

extension DateExtention on DateTime {
  String format() => DateFormat('yyyy/MM/dd HH:mm').format(this);
}

