import 'package:intl/intl.dart';

DateTime stringToDate(String dateString) {
  DateTime parsedDateTime = DateTime.parse(dateString);

  // Create a new DateTime object with only year, month, day, hour, and minute
  DateTime resultDateTime = DateTime(
    parsedDateTime.year,
    parsedDateTime.month,
    parsedDateTime.day,
    parsedDateTime.hour,
    parsedDateTime.minute,
  );

  return resultDateTime;
}

DateTime formatDate(DateTime date) {
  DateTime resultDateTime = DateTime(
    date.year,
    date.month,
    date.day,
    date.hour,
    date.minute,
  );

  return resultDateTime;
}

String stringDate(DateTime date) {
  String formattedDateString = DateFormat("yy-MM-dd HH:mm").format(date);

  return formattedDateString;
}
