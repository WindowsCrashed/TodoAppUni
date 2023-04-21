import 'package:todo_app_uni/models/task_priority.dart';
import 'package:todo_app_uni/models/task_type.dart';
import 'package:intl/intl.dart';

class Task {
  String name;
  TaskType type;
  TaskPriority priority;
  String description;
  DateTime date;

  Task({
    required this.name,
    required this.type,
    required this.priority,
    this.description = '',
    required this.date
  });

  String getDate() => DateFormat('dd/MM/yy').format(date);
  String getTime() => DateFormat('HH:mm').format(date);
}