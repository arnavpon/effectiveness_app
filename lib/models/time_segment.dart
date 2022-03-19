import 'package:flutter/material.dart';

class TimeSegment {
  static const String KEY_HOUR_STRING = "key_hour_string";
  static const String KEY_HOUR_MODIFIER = "key_hour_modifier";

  final DateTime startTime;
  final DateTime endTime;

  // MARK: - Constructors

  const TimeSegment(this.startTime, this.endTime); // default constructor
  TimeSegment.withDuration(this.startTime, Duration duration)
      : endTime = startTime.add(duration); // constructor 2

  // MARK: - Computed Properties

  TimeOfDay get startTimeOfDay =>
      TimeOfDay(hour: startTime.hour, minute: startTime.minute);
  TimeOfDay get endTimeOfDay =>
      TimeOfDay(hour: endTime.hour, minute: endTime.minute);

  String get readableStartTime {
    var startHour = _formatHour(startTime.hour);
    var startMinute = _formatMinute(startTime.minute);
    return "${startHour[KEY_HOUR_STRING]}:$startMinute ${startHour[KEY_HOUR_MODIFIER]}";
  }

  String get readableEndTime {
    var endHour = _formatHour(endTime.hour);
    var endMinute = _formatMinute(endTime.minute);
    return "${endHour[KEY_HOUR_STRING]}:$endMinute ${endHour[KEY_HOUR_MODIFIER]}";
  }

  String get readableFullString {
    // returns a human readable string for the time segment
    return "$readableStartTime - $readableEndTime";
  }

  Duration get duration {
    return endTime.difference(startTime);
  }

  // MARK: - Instance Methods

  String _formatMinute(int minute) {
    /// Adds trailing zero to minutes
    return (minute < 10) ? "0$minute" : "$minute";
  }

  Map<String, String> _formatHour(int hour) {
    /// Creates readable string with modifier (AM/PM) for hour value
    String formattedString = "$hour";
    String modifier = "AM";
    if (hour == 0) {
      formattedString = "12";
    } else if (hour >= 12) {
      if (hour > 12) {
        formattedString = "${hour - 12}";
      }
      modifier = "PM";
    }
    return {KEY_HOUR_STRING: formattedString, KEY_HOUR_MODIFIER: modifier};
  }
}
