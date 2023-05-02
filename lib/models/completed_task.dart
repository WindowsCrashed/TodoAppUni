import 'package:intl/intl.dart';
import 'package:todo_app_uni/models/task.dart';

class CompletedTask {
  Task task;
  late DateTime conclusionDate;
  late bool success;

  CompletedTask({required this.task}) {
    conclusionDate = DateTime.now();

    if (task.date.isAfter(conclusionDate)
        || task.date.isAtSameMomentAs(conclusionDate)) {
      success = true;
    } else {
      success = false;
    }
  }

  String getDate() => DateFormat('dd/MM/yy').format(conclusionDate);
  String getTime() => DateFormat('HH:mm').format(conclusionDate);
}