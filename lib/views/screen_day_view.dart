import 'dart:developer';

import 'package:flutter/material.dart';

class DayViewScreen extends StatefulWidget {
  const DayViewScreen({Key? key, required this.day}) : super(key: key);

  DayViewScreen.today({Key? key})
      : day = DateUtils.dateOnly(DateTime.now()),
        super(key: key);

  final DateTime day; // day that this view describes

  @override
  State<DayViewScreen> createState() => _DayViewScreenState();
}

class _DayViewScreenState extends State<DayViewScreen> {
  DateTime? _startTime;

  final String KEY_HOUR_STRING = "key_hour_string";
  final String KEY_HOUR_MODIFIER = "key_hour_modifier";

  Map<String, String> formatHour(int hour) {
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

  String formatMinute(int minute) {
    /// Adds trailing zero to minutes
    return (minute < 10) ? "0$minute" : "$minute";
  }

  @override
  initState() {
    super.initState();
    _segments = List.generate((24 * 6), (index) {
      var tsStart = widget.day.add(Duration(minutes: index * 10));
      var tsEnd = tsStart.add(const Duration(minutes: 10));
      var startHour = formatHour(tsStart.hour);
      var startMinute = formatMinute(tsStart.minute);
      var endHour = formatHour(tsEnd.hour);
      var endMinute = formatMinute(tsEnd.minute);

      return "${startHour[KEY_HOUR_STRING]}:$startMinute ${startHour[KEY_HOUR_MODIFIER]} - ${endHour[KEY_HOUR_STRING]}:$endMinute ${endHour[KEY_HOUR_MODIFIER]}";
    });
  }

  List<String> _segments = <String>[];

  void _pinStartTime() {
    // toggle pin on & off, create item when toggled off
    _startTime = DateTime.now();
    log("Pinned at ${_startTime!.toIso8601String()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.day.month}/${widget.day.day}/${widget.day.year}"),
      ),
      body: ListView.builder(
          itemCount: _segments.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_segments[index]),
              subtitle: const Text("Activity?"),
              onTap: () {
                // navigate to edit view (form)
                print("tapped @ index $index");
              },
              selected: false,
              selectedTileColor: Colors.blue,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _pinStartTime,
        child: const Icon(Icons.add),
      ),
    );
  }
}
