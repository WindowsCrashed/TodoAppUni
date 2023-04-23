import 'package:todo_app_uni/models/task_priority.dart';
import 'package:todo_app_uni/models/validation_response.dart';
import 'package:todo_app_uni/data/db.dart';

class TaskPriorityService {
  ValidationResponse _validateNewTaskPriority(TaskPriority priority) {
    if (Db.priorities.any((p) => p.priority == priority.priority)) {
      return ValidationResponse(
          response: false, message: 'This task priority already exists. Try again.'
      );
    }
    return ValidationResponse(response: true, message: 'Task priority successfully created.');
  }

  ValidationResponse addTaskPriority(Map taskPriority) {
    TaskPriority newTaskPriority = TaskPriority(
      priority: taskPriority['priority'],
      color: taskPriority['color'],
      icon: taskPriority['icon']
    );
    ValidationResponse response = _validateNewTaskPriority(newTaskPriority);
    if (response.response) {
      Db.priorities.add(newTaskPriority);
    }
    return response;
  }

  List<TaskPriority> getPriorities() {
    return Db.priorities;
  }

  TaskPriority getPriority(String name) {
    return Db.priorities.firstWhere((p) => p.priority == name);
  }
}
