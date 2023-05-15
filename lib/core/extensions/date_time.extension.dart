import 'package:date_format/date_format.dart';

extension DateTimeExtension on DateTime {
  //* format function to format a date into ex: 4th April 2022 format
  String format() {
    return formatDate(this, [d, 'th ', MM, ' ', yyyy]);
  }
}
