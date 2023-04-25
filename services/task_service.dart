import 'package:todo_app_uni/models/task.dart';
import 'package:todo_app_uni/models/validation_response.dart';
import 'package:todo_app_uni/data/db.dart';

class TaskService {
  ValidationResponse _validateNewTask(Task task) {
    if (Db.tasks.any((t) => t.name == task.name)) {
      return ValidationResponse(
          response: false, message: 'This task exists. Try again.'
      );
    }
    return ValidationResponse(response: true, message: 'Task successfully created.');
  }

  ValidationResponse addTask(Map task) {
    DateTime date = DateTime(
        task['date'].year, task['date'].month, task['date'].day,
        task['time'].hour, task['time'].minute
    );

    Task newTask = Task(
        name: task['name'],
        description: task['description'],
        date: date,
        priority: task['priority'],
        types: task['types']
    );

    ValidationResponse response = _validateNewTask(newTask);
    if (response.response) {
      Db.tasks.add(newTask);
    }
    return response;
  }

  List<Task> getTasks() {
    return Db.tasks;
  }

  Task getTask(String name) {
    return Db.tasks.firstWhere((t) => t.name == name);
  }

  String deleteTask(String name) {
    Task? task = getTask(name);
    Db.tasks.remove(task);
    return 'Task successfully removed.';
  }

  String completeTask(String name) {
    Task? task = getTask(name);
    Db.completedTasks.add(task);
    Db.tasks.remove(task);
    return 'Task successfully completed.';
  }
}
