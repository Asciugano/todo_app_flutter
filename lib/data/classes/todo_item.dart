import 'package:todo_app_flutter/data/classes/priority_level.dart';

class TodoItem {
  final String title;
  final String desctiption;
  final DateTime creationTime;
  final DateTime? scadenza;
  final PriorityLevel? priorityLevel;
  
  const TodoItem({
    required this.title,
    required this.desctiption,
    required this.creationTime,
    this.scadenza,
    this.priorityLevel,
  });
}