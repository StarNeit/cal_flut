class CalendarEvent {
  final String title;
  final DateTime datetime;
  final String? desc;

  CalendarEvent({
    required this.title,
    required this.datetime,
    this.desc,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      title: json['title'],
      datetime: DateTime.parse(json['datetime']),
      desc: json['desc'],
    );
  }
}