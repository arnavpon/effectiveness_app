import 'package:effectivess_app/models/status.dart';
import 'package:effectivess_app/models/time_segment.dart';

class Activity {
  final String title;
  Status status = Status.active;
  List<Activity> children = [];
  List<TimeSegment> timeSegments = [];
  List<String> tags = [];
  int value = 0;
  double correctedUrgency = 0;

  Activity({required this.title});

  String getReadableStatus() {
    switch (status) {
      case Status.completed:
        return "Completed";
      case Status.awaiting:
        return "Awaiting";
      case Status.active:
        return "Active";
    }
  }
}
