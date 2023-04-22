import 'package:flutter/material.dart';
import 'package:todo_app_uni/models/validation_response.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/services/task_type_service.dart';

class CreateTaskType extends StatefulWidget {
  const CreateTaskType({Key? key}) : super(key: key);

  @override
  State<CreateTaskType> createState() => _CreateTaskTypeState();
}

class _CreateTaskTypeState extends State<CreateTaskType> {
  final _formKey = GlobalKey<FormState>();
  final _taskTypeService = TaskTypeService();

  final TextEditingController fieldController = TextEditingController();

  void save() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      ValidationResponse response = _taskTypeService.addTaskType(fieldController.text);
      if (response.response) {
        Navigator.pop(context);
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message)));
    }
  }

  void cancel() {
    Navigator.pop(context);
  }

  @override void dispose() {
    fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppAppBar(title: 'Create Task Type'),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 25),
          child: GestureDetector(
            child: Column(
              children: [
                const Text('Create a new task type',
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
                        SizedBox(
                          height: 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 210,
                                child: ElevatedButton(
                                    onPressed: save,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                                    ),
                                    child: const Text('Save',
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: 210,
                                child: OutlinedButton(
                                    onPressed: cancel,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black54,
                                      side: const BorderSide(width: 2, color: Colors.black54)
                                    ),
                                    child: const Text('Cancel',
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
