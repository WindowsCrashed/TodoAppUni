import 'package:flutter/material.dart';
import 'package:todo_app_uni/helpers/show_confirm_deletion_dialog.dart';
import 'package:todo_app_uni/models/task_priority.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/services/task_priority_service.dart';

class ListTaskPriorities extends StatefulWidget {
  const ListTaskPriorities({Key? key}) : super(key: key);

  @override
  State<ListTaskPriorities> createState() => _ListTaskPrioritiesState();
}

class _ListTaskPrioritiesState extends State<ListTaskPriorities> {
  final _taskPriorityService = TaskPriorityService();

  void _deletePriority(TaskPriority priority) {
    String response = _taskPriorityService.deletePriority(priority.priority);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response), duration: const Duration(seconds: 3),)
    );
    Navigator.popUntil(context, ModalRoute.withName('/list-task-priorities'));
    setState(() {});
  }

  void _showPriorityDialog(context, TaskPriority priority) => showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 20),
        title: Column(
          children: [
            Text(priority.priority,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: priority.color
              ),
            ),
            ...(priority.icon != null ? [
              const SizedBox(height: 10,),
              Icon(priority.icon,
                size: 32,
                color: priority.color,
              )
            ] : [])
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleDialogOption(
                onPressed: () => showConfirmDeletionDialog(
                    context: context, onPressed: () => _deletePriority(priority)),
                child: const Text('Delete',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/edit-task-priority',
                    arguments: { 'priority': priority }
                  );
                  setState(() {});
                },
                child: const Text('Edit',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue
                  ),
                ),
              ),
            ],
          )
        ],
      )
  );

  Widget _buildList(context, index, priorities) {
    final TaskPriority priority = priorities[index];

    return ListTile(
      title: Row(
        children: [
          Text(priority.priority,
            style: TextStyle(
                fontSize: 20,
                color: priority.color,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(width: 12,),
          Icon(priority.icon,
            size: 28,
            color: priority.color,
          ),
        ],
      ),
      onTap: () => _showPriorityDialog(context, priorities[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TaskPriority> priorities = _taskPriorityService.getPriorities();

    return Scaffold(
      appBar: const AppAppBar(title: 'Task priorities'),
      body: ListView.separated(
        itemCount: priorities.length,
        itemBuilder: (context, index) => _buildList(context, index, priorities),
        separatorBuilder: (context, index) => const Divider(thickness: 1.2,),
      ),
    );
  }
}
