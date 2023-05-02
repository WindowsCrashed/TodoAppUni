import 'package:flutter/material.dart';
import 'package:todo_app_uni/helpers/show_confirm_deletion_dialog.dart';
import 'package:todo_app_uni/models/task.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/models/task_type.dart';
import 'package:todo_app_uni/widgets/task_type_chip_big.dart';
import 'package:todo_app_uni/services/task_service.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  final _taskService = TaskService();

  List<Widget> _generateTags(List<TaskType>? types) {
    if (types == null) return [];
    return types.map((t) => TaskTypeChipBig(label: t.type,)).toList();
  }

  void _markAsCompleted(String task, BuildContext context) {
    String response = _taskService.completeTask(task);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response), duration: const Duration(seconds: 3),)
    );
    Navigator.pop(context);
  }

  void _deleteTask(String task) {
    String response = _taskService.deleteTask(task);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response), duration: const Duration(seconds: 3),)
    );
    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }

  void _editTask(Task task) async {
    await Navigator.pushNamed(context, '/edit-task',
      arguments: { 'task': task }
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Task task = (ModalRoute.of(context)!.settings.arguments as Map)['task'];

    return Scaffold(
        appBar: const AppAppBar(
          title: 'Task',
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
            child: Column(
              children: [
                Text(task.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70,),
                Text(task.description,
                  style: const TextStyle(
                      fontSize: 18
                  ),
                ),
                const SizedBox(height: 40,),
                Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 12,
                    children: _generateTags(task.types)
                ),
                const SizedBox(height: 40,),
                Column(
                  children: [
                    const Text('Deadline:',
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Text(task.getDate(),
                      style: const TextStyle(
                          fontSize: 28
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(task.getTime(),
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40,),
                Column(
                  children: [
                    const Text('Priority:',
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (task.priority.icon != null)
                          ...[Icon(task.priority.icon,
                            color: task.priority.color,
                            size: 35,
                          ),
                            const SizedBox(width: 10,)],
                        Text(task.priority.priority,
                          style: TextStyle(
                              color: task.priority.color,
                              fontSize: 30
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 55,),
                    Column(
                      children: [
                        SizedBox(
                          width: 240,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => _markAsCompleted(task.name, context),
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.green)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.check),
                                SizedBox(width: 10,),
                                Text('Mark as completed',
                                  style: TextStyle(
                                      fontSize: 20
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50,),
                        SizedBox(
                          width: 280,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 125,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () => showConfirmDeletionDialog(
                                      context: context, onPressed: () => _deleteTask(task.name)),
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.red)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.delete),
                                      SizedBox(width: 10,),
                                      Text('Delete',
                                        style: TextStyle(
                                            fontSize: 20
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 125,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () => _editTask(task),
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.amber)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.edit),
                                      SizedBox(width: 10,),
                                      Text('Edit',
                                        style: TextStyle(
                                            fontSize: 20
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}