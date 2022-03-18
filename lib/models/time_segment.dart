class TimeSegment {
  final DateTime startTime;
  final DateTime endTime;

  const TimeSegment(this.startTime, this.endTime); // default constructor
  TimeSegment.withDuration(this.startTime, Duration duration)
      : endTime = startTime.add(duration); // constructor 2

  // don't assume 10 minute time increments, make this flexible
  // allows flexible view (when we select new segment length, auto-increments view)
}
