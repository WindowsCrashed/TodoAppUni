import 'package:flutter/material.dart';
import 'package:todo_app_uni/helpers/show_confirm_deletion_dialog.dart';
import 'package:todo_app_uni/models/task_type.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/services/task_type_service.dart';

class ListTaskTypes extends StatefulWidget {
  const ListTaskTypes({Key? key}) : super(key: key);

  @override
  State<ListTaskTypes> createState() => _ListTaskTypesState();
}

class _ListTaskTypesState extends State<ListTaskTypes> {
  final _taskTypeService = TaskTypeService();

  void _deleteType(TaskType type) {
    String response = _taskTypeService.deleteType(type.type);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response), duration: const Duration(seconds: 3),)
    );
    Navigator.popUntil(context, ModalRoute.withName('/list-task-types'));
    setState(() {});
  }
  
  void _showTypeDialog(context, TaskType type) => showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 20),
        title: Text(type.type,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleDialogOption(
                onPressed: () => showConfirmDeletionDialog(
                    context: context, onPressed: () => _deleteType(type)),
                child: const Text('Delete',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/edit-task-type',
                      arguments: { 'type': type });
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

  Widget _buildList(context, index, types) {
    return ListTile(
      title: Text(types[index].type,
        style: const TextStyle(
          fontSize: 20
        ),
      ),
      onTap: () => _showTypeDialog(context, types[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TaskType> types = _taskTypeService.getTypes();

    return Scaffold(
      appBar: const AppAppBar(title: 'Task types'),
      body: ListView.separated(
        itemCount: types.length,
        itemBuilder: (context, index) => _buildList(context, index, types),
        separatorBuilder: (context, index) => const Divider(thickness: 1.2,),
      ),
    );
  }
}
