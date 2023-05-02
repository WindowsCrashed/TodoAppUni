import 'package:todo_app_uni/models/task_type.dart';
import 'package:todo_app_uni/data/db.dart';
import 'package:todo_app_uni/models/validation_response.dart';

class TaskTypeService {
  ValidationResponse _validateNewTaskType(TaskType type) {
    if (Db.types.any((t) => t.type == type.type)) {
      return ValidationResponse(
        response: false, message: 'This task type already exists. Try again.'
      );
    }
    return ValidationResponse(response: true, message: 'Task type successfully created.');
  }

  ValidationResponse addTaskType(String type) {
    TaskType newTaskType = TaskType(type);
    ValidationResponse response = _validateNewTaskType(newTaskType);
    if (response.response) {
      Db.types.add(newTaskType);
    }
    return response;
  }

  List<TaskType> getTypes() {
    return Db.types;
  }

  TaskType getType(String name) {
    return Db.types.firstWhere((t) => t.type == name);
  }

  String editTaskType(String type, String newType) {
    getType(type).type = newType;
    return 'Task type successfully updated.';
  }

  String deleteType(String name) {
    TaskType? type = getType(name);
    Db.types.remove(type);
    return 'Task type successfully removed.';
  }
}