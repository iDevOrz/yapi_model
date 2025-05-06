import 'package:intl/intl.dart' show DateFormat;

extension DateFormatExtension on DateTime {
  static final _dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");

  String get format {
    return _dateFormat.format(this);
  }
}
