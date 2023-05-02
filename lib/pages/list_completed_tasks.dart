import 'package:flutter/material.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/services/task_service.dart';
import 'package:todo_app_uni/models/completed_task.dart';
import 'package:todo_app_uni/helpers/show_confirm_deletion_dialog.dart';

class ListCompletedTasks extends StatefulWidget {
  const ListCompletedTasks({Key? key}) : super(key: key);

  @override
  State<ListCompletedTasks> createState() => _ListCompletedTasksState();
}

class _ListCompletedTasksState extends State<ListCompletedTasks> {
  final _taskService = TaskService();

  void _deleteTask(CompletedTask completedTask) {
    String response = _taskService.deleteCompletedTask(completedTask.task.name);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response), duration: const Duration(seconds: 3),)
    );
    Navigator.popUntil(context, ModalRoute.withName('/list-completed-tasks'));
    setState(() {});
  }

  void _showCompletedTaskDialog(context, CompletedTask completedTask) => showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 20),
        title: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(completedTask.task.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Text(completedTask.task.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey
              ),
            ),
            const SizedBox(height: 24,),
            const Text('Deadline:',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black26,
                fontStyle: FontStyle.italic,
                fontSize: 12
              ),
            ),
            SizedBox(
              height: 35,
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(completedTask.task.getDate()),
                  Text(completedTask.task.getTime())
                ],
              ),
            ),
            const SizedBox(height: 24,),
            const Text('Completed at:',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black26,
                  fontStyle: FontStyle.italic,
                  fontSize: 14
              ),
            ),
            SizedBox(
              height: 35,
              width: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(completedTask.getDate(),
                    style: TextStyle(
                      color: completedTask.success ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  Text(completedTask.getTime(),
                    style: TextStyle(
                        color: completedTask.success ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24,),
            const Text('Status:',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black26,
                  fontStyle: FontStyle.italic,
                  fontSize: 14
              ),
            ),
            SizedBox(
              height: 35,
              width: 150,
              child: Text(completedTask.success ? 'Success' : 'Failure',
                style: TextStyle(
                    color: completedTask.success ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
                textAlign: TextAlign.center,
              )
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleDialogOption(
                onPressed: () => showConfirmDeletionDialog(context: context, onPressed: () => _deleteTask(completedTask)),
                child: const Text('Delete',
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

  Widget _buildList(context, index, completedTasks) {
    final CompletedTask completedTask = completedTasks[index];

    return ListTile(
      title: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              child: Text(completedTask.task.name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // const SizedBox(width: 12,),
            Icon(completedTask.success ? Icons.check : Icons.close,
              color: completedTask.success ? Colors.green : Colors.red,
              size: 30,
            )
          ],
        ),
      ),
      onTap: () => _showCompletedTaskDialog(context, completedTasks[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<CompletedTask> completeTasks = _taskService.getCompletedTasks();

    return Scaffold(
      appBar: const AppAppBar(title: 'Completed Tasks'),
      body: ListView.separated(
        itemCount: completeTasks.length,
        itemBuilder: (context, index) => _buildList(context, index, completeTasks),
        separatorBuilder: (context, index) => const Divider(thickness: 1.2,),
      ),
    );
  }
}
