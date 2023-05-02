import 'package:flutter/material.dart';
import 'package:todo_app_uni/models/task_type.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/services/task_type_service.dart';
import 'package:todo_app_uni/widgets/save_cancel_buttons.dart';

class EditTaskType extends StatefulWidget {
  const EditTaskType({Key? key}) : super(key: key);

  @override
  State<EditTaskType> createState() => _EditTaskTypeState();
}

class _EditTaskTypeState extends State<EditTaskType> {
  final _formKey = GlobalKey<FormState>();
  final _taskTypeService = TaskTypeService();

  final TextEditingController fieldController = TextEditingController();

  TaskType? _type;

  void save() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      String response = _taskTypeService
          .editTaskType(_type!.type, fieldController.text);
      Navigator.popUntil(context, ModalRoute.withName('/list-task-types'));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response), duration: const Duration(seconds: 3))
      );
    }
  }

  @override void dispose() {
    fieldController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_type == null) {
      _type = (ModalRoute.of(context)!.settings.arguments as Map)['type'];
      fieldController.text = _type!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const AppAppBar(title: 'Edit Task Type'),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 25),
            child: GestureDetector(
              child: Column(
                children: [
                  const Text('Edit a task type',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      height: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormField(
                            controller: fieldController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Task type',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field';
                              }
                              return null;
                            },
                          ),
                          SaveCancelButtons(onSave: save, context: context)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
