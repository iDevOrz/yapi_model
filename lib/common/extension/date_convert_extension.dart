import 'package:yapi_model/common/extension/date_format_extension.dart';

extension DateConvertExtension on int {
  DateTime get secondsSinceEpochToDate {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000);
  }

  String get format {
    return secondsSinceEpochToDate.format;
  }
}
