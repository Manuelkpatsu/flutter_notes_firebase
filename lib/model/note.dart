import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final String userId;
  final String description;
  final int color;
  final int priority;
  final Timestamp createdAt;

  Note({
    required this.id,
    required this.title,
    required this.userId,
    required this.description,
    required this.color,
    required this.priority,
    required this.createdAt,
  });

  Note.fromSnapshot(id, Map<String, dynamic> json)
      : this(
          id: id,
          title: json['title'],
          userId: json['userId'],
          description: json['description'],
          color: json['color'],
          priority: json['priority'],
          createdAt: json['createdAt'],
        );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'userId': userId,
      'color': color,
      'priority': priority,
      'createdAt': createdAt,
    };
  }

  String getDate(Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch)
        .toString();
  }
}
