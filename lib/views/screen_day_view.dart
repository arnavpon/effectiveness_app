import 'dart:developer';

import 'package:effectivess_app/models/activity.dart';
import 'package:effectivess_app/models/time_segment.dart';
import 'package:effectivess_app/views/activity_form.dart';
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

  @override
  initState() {
    super.initState();
    _segments = List.generate((24 * 6), (index) {
      var tsStart = widget.day.add(Duration(minutes: index * 10));
      var tsEnd = tsStart.add(const Duration(minutes: 10));
      return TimeSegment(tsStart, tsEnd);
    });
    _activities[_segments[3]] = Activity(title: "Test Activity"); // ***
  }

  List<TimeSegment> _segments = <TimeSegment>[]; // data source for UI list view
  final Map<TimeSegment, Activity> _activities =
      {}; // existing activities for day, best way to index this?

  void _pinStartTime() {
    // toggle pin on & off, create item when toggled off
    _startTime = DateTime.now();
    log("Pinned at ${_startTime!.toIso8601String()}");
  }

  bool _activityExistsForSegment(int index) {
    return _activities.containsKey(_segments[index]);
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
              title: Text(_segments[index].readableFullString),
              subtitle: (_activityExistsForSegment(index))
                  ? Text(_activities[_segments[index]]!.title)
                  : null,
              onTap: () {
                // navigate to edit view (form)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text(
                                "${(_activityExistsForSegment(index)) ? "Edit" : "Add"} Activity"),
                          ),
                          body: (_activityExistsForSegment(index))
                              ? ActivityForm.fromActivity(
                                  timeSegment: _segments[index],
                                  activity: _activities[_segments[index]],
                                )
                              : ActivityForm(timeSegment: _segments[index]),
                        )));
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
