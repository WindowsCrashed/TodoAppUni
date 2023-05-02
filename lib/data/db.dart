import 'package:todo_app_uni/models/completed_task.dart';
import 'package:todo_app_uni/models/task.dart';
import 'package:todo_app_uni/models/task_type.dart';
import 'package:todo_app_uni/models/task_priority.dart';

class Db {
  static final List<Task> tasks = [];
  static final List<TaskPriority> priorities = [];
  static final List<TaskType> types = [];
  static final List<CompletedTask> completedTasks = [];
}