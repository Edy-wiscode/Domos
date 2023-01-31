
class Alarm {
  final int id;
  final String title;
  final String time;
  Alarm({required this.id, required this.title, required this.time});
  Map<String, dynamic> alarmMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
    };
  }

  @override
  String toString() {
    return 'Alarm{id: $id, title: $title, time: $time}';
  }

}
