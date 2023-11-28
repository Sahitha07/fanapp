import 'package:fan_project/utilityFunctions/dateConversion.dart';

class Events {
  String? eventId;
  final DateTime date;
  final String title;
  final String? description;
  List<Map<String, dynamic>>? media;
  String location;
  Events(
      {this.eventId,
      required this.date,
      required this.title,
      this.media,
      this.description,
      required this.location});

  Map<String, dynamic> toMap() {
    return {
      'id': eventId,
      'title': title,
      'date': date,
      'media': media,
      'location': location,
      'description': description,
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
        eventId: map['id'] ?? "",
        title: map['title'],
        date: map['date'].toDate() ?? DateTime.now(),
        media: List<Map<String, dynamic>>.from(map['media'] ?? []),
        location: map['location'] ?? '',
        description: map['description'] ?? '');
  }
}
