import 'dart:developer';

import 'package:effectivess_app/views/screen_block_view.dart';
import 'package:effectivess_app/models/activity.dart';
import 'package:effectivess_app/models/time_segment.dart';
import 'package:effectivess_app/views/activity_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    // use Provider.of<MongoHandler>(context).runMongo() to pull activities for segments
    _activities[_segments[3]] = Activity(title: "Test Activity"); // ***
  }

  List<TimeSegment> _segments = <TimeSegment>[]; // data source for UI list view
  final Map<TimeSegment, Activity> _activities =
      {}; // existing activities for day, best way to index this?

  void _pinStartTime() async {
    // toggle pin on & off, create item when toggled off
    if (_startTime == null) {
      setState(() {
        _startTime = DateTime.now();
      });
      log("Pinned at ${_startTime!.toIso8601String()}");
    } else {
      var segment = TimeSegment(_startTime!, DateTime.now());
      log("Pin lasted for ${segment.duration.inMinutes} minutes");
      await _goToActivityForm(segment); // navigate to create activity page
      setState(() {
        _startTime = null; // clear value
      });
    }
  }

  bool _activityExistsForSegment(int index) {
    return _activities.containsKey(_segments[index]);
  }

  Future _goToActivityForm(TimeSegment timeSegment,
      {Activity? activity}) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text("${(activity != null) ? "Edit" : "Add"} Activity"),
              ),
              body: (activity != null)
                  ? ActivityForm.fromActivity(
                      timeSegment: timeSegment,
                      activity: activity,
                    )
                  : ActivityForm(timeSegment: timeSegment),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.day.month}/${widget.day.day}/${widget.day.year}"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BlockViewScreen(),
              ));
            },
            child: const Icon(
              Icons.square_rounded,
              size: 40,
              color: Colors.red,
            ),
          )
        ],
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
                var ts = _segments[index];
                (_activityExistsForSegment(index))
                    ? _goToActivityForm(
                        ts,
                        activity: _activities[_segments[index]],
                      )
                    : _goToActivityForm(ts); // navigate to edit view (form)
              },
              selected: false,
              selectedTileColor: Colors.blue,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _pinStartTime,
        child: Icon(Icons.pin_invoke_sharp,
            color: (_startTime == null) ? Colors.white : Colors.red),
      ),
    );
  }
}
