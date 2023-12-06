import 'package:intl/intl.dart';

class Formatter {
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _dateFormat = DateFormat('dd.MM.yyyy');

  static formatDate(DateTime date) => _dateFormat.format(date);

  static formatTime(DateTime date) => _timeFormat.format(date);
}
