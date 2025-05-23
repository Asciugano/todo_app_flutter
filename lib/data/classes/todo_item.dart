import 'package:todo_app_flutter/data/classes/priority_level.dart';

class TodoItem {
  int listID;
  String title;
  String desctiption;
  bool isCompleted;
  final DateTime creationTime;
  PriorityLevel priorityLevel;
  DateTime? scadenza;

  TodoItem({
    required this.listID,
    required this.title,
    required this.desctiption,
    required this.isCompleted,
    required this.creationTime,
    required this.priorityLevel,
    this.scadenza,
  });

  Map<String, dynamic> toJson() {
    return {
      'listID': listID,
      'title': title,
      'desctiption': desctiption,
      'isCompleted': isCompleted,
      'creationTime': creationTime.toIso8601String(),
      'priorityLevel': priorityLevel.level,
      'scadenza':
          scadenza != null ? scadenza!.toIso8601String() : 'nessuna scadenza',
    };
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'],
      listID: json['listID'],
      desctiption: json['desctiption'],
      isCompleted: json['isCompleted'],
      creationTime: DateTime.parse(json['creationTime']),
      priorityLevel: PriorityLevel.values[json['priorityLevel']],
      scadenza:
          json['scadenza'] == 'nessuna scadenza'
              ? null
              : DateTime.parse(json['scadenza']),
    );
  }
}