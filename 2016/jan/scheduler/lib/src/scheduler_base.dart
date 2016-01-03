library scheduler.base;


class TimeSlot {
  String name, description;
  DateTime start, end;
  TimeSlot(this.name, this.start, this.end, {this.description: ''});
  Duration get duration => end.difference(start);
}