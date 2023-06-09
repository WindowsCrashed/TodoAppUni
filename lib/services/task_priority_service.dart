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

  String editPriority(TaskPriority priority, Map newPriority) {
    getPriority(priority.priority).priority = newPriority['priority'];
    getPriority(priority.priority).color = newPriority['color'];
    getPriority(priority.priority).icon = newPriority['icon'];
    return 'Task priority successfully updated.';
  }

  String deletePriority(String name) {
    TaskPriority? priority = getPriority(name);
    Db.priorities.remove(priority);
    return 'Task priority successfully removed.';
  }
}
