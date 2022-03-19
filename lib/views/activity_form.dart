import 'package:flutter/material.dart';
import 'package:effectivess_app/models/activity.dart';
import 'package:effectivess_app/models/time_segment.dart';

class ActivityForm extends StatefulWidget {
  const ActivityForm({Key? key, required this.timeSegment})
      : activity = null,
        super(key: key);
  const ActivityForm.fromActivity(
      {Key? key, required this.timeSegment, required this.activity})
      : super(key: key);

  final TimeSegment timeSegment;
  final Activity? activity;

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final _formKey = GlobalKey<FormState>();
  Activity _activity = Activity(title: "");
  TimeSegment _timeSegment = TimeSegment(DateTime.now(), DateTime.now());

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _timeSegment = widget.timeSegment;
        if (widget.activity != null) {
          _activity = widget.activity!;
        }
      });
    });
  }

  Future _selectStartTime() async {
    var tod = await showTimePicker(
        context: context, initialTime: _timeSegment.startTimeOfDay);
    if (tod != null) {
      // update timeSegment
      var start = DateTime(
          _timeSegment.startTime.year,
          _timeSegment.startTime.month,
          _timeSegment.startTime.day,
          tod.hour,
          tod.minute);
      if (_timeSegment.endTime.isAfter(start)) {
        // safety check that startTime < endTime
        setState(() {
          _timeSegment = TimeSegment(start, _timeSegment.endTime);
        });
      }
    }
  }

  Future _selectEndTime() async {
    var tod = await showTimePicker(
        context: context, initialTime: _timeSegment.endTimeOfDay);
    if (tod != null) {
      // update timeSegment
      var end = DateTime(
          _timeSegment.startTime.year,
          _timeSegment.startTime.month,
          _timeSegment.startTime.day,
          tod.hour,
          tod.minute);
      if (_timeSegment.startTime.isBefore(end)) {
        // safety check that startTime < endTime
        setState(() {
          _timeSegment = TimeSegment(_timeSegment.startTime, end);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Title: "),
            TextFormField(
              initialValue: widget.activity?.title,
              validator: (value) =>
                  (value == null || value.isEmpty) ? "Title is required" : null,
            ),
            const Text("Start Time: "),
            ElevatedButton(
                onPressed: _selectStartTime,
                child: Text(_timeSegment.readableStartTime)),
            const Text("End Time: "),
            ElevatedButton(
                onPressed: _selectEndTime,
                child: Text(_timeSegment.readableEndTime)),
            Text("Current Status: ${_activity.getReadableStatus()}"),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // store activity in db & navigate back
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Done"),
            )
          ],
        ));
  }
}
