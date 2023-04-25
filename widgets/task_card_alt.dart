import 'package:flutter/material.dart';
import 'package:todo_app_uni/models/task.dart';
import 'package:todo_app_uni/models/task_type.dart';
import 'package:todo_app_uni/widgets/task_type_chip.dart';
import 'package:todo_app_uni/services/task_service.dart';

class TaskCardAlt extends StatefulWidget {
  final Task task;
  final Function setStateCallback;

  const TaskCardAlt({Key? key, required this.task, required this.setStateCallback})
      : super(key: key);

  @override
  State<TaskCardAlt> createState() => _TaskCardAltState();
}

class _TaskCardAltState extends State<TaskCardAlt> {
  final _taskService = TaskService();

  List<Widget> generateTags(List<TaskType>? types) {
    if (types == null) return [];
    return types.map((t) => TaskTypeChip(label: t.type,)).toList();
  }

  void _removeTask() {
    String response = _taskService.deleteTask(widget.task.name);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response), duration: const Duration(seconds: 3),)
    );
    widget.setStateCallback();
  }

  void _completeTask() {
    String response = _taskService.completeTask(widget.task.name);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response), duration: const Duration(seconds: 3),)
    );
    widget.setStateCallback();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: SizedBox(
          height: 135,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 215,
                  child: SizedBox(
                    height: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.task.name,
                          style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(widget.task.getDate(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text(widget.task.getTime(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: [
                              Text(widget.task.priority.priority,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: widget.task.priority.color,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(widget.task.priority.icon,
                                  color: widget.task.priority.color,
                                ),
                              ),
                            ]
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ElevatedButton(
                              onPressed: _completeTask,
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.green),
                              ),
                              child: const Icon(Icons.check, size: 20,)
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ElevatedButton(
                              onPressed: _removeTask,
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.red),
                              ),
                              child: const Icon(Icons.close, size: 20,)
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
