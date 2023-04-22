import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:todo_app_uni/models/validation_response.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/services/task_type_service.dart';

class CreateTaskPriority extends StatefulWidget {
  const CreateTaskPriority({Key? key}) : super(key: key);

  @override
  State<CreateTaskPriority> createState() => _CreateTaskPriorityState();
}

class _CreateTaskPriorityState extends State<CreateTaskPriority> {
  final _formKey = GlobalKey<FormState>();
  // final _taskTypeService = TaskTypeService();

  final TextEditingController priorityController = TextEditingController();

  IconData? _icon;
  // IconData? icon = Icons.warning_amber;
  Color _color = Colors.black;

  void save() {
    // if (_formKey.currentState!.validate()) {
    //   FocusScope.of(context).unfocus();
    //   ValidationResponse response = _taskTypeService.addTaskType(fieldController.text);
    //   if (response.response) {
    //     Navigator.pop(context);
    //   }
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message)));
    // }
  }

  void cancel() {
    Navigator.pop(context);
  }

  void _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context, iconPackModes: [IconPack.material]);
    _icon = icon;
    setState(() {});
  }

  void _pickColor(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select a color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlockPicker(
                pickerColor: _color,
                availableColors: const [
                  Colors.black,
                  Colors.blueGrey,
                  Colors.grey,
                  Colors.brown,
                  Colors.deepPurple,
                  Colors.indigo,
                  Colors.blue,
                  Colors.cyan,
                  Colors.teal,
                  Colors.green,
                  Colors.lightGreen,
                  Colors.purpleAccent,
                  Colors.red,
                  Colors.deepOrangeAccent,
                  Colors.orange,
                  Colors.amber,
                ],
                onColorChanged: (color) => setState(() {
                  _color = color;
                })
            ),
            TextButton(
              child: const Text('Select',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      )
  );

  Widget _displayIcon() {
    if (_icon == null) {
      return Text('None',
        style: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
          color: Colors.grey.shade400
        ),
      );
    } else {
      return Icon(_icon, size: 40);
    }
  }

  @override void dispose() {
    priorityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppAppBar(title: 'Create Task Priority'),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 25),
          child: GestureDetector(
            child: Column(
              children: [
                const Text('Create a new task priority',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    height: 345,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextFormField(
                                controller: priorityController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Priority',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required field';
                                  }
                                  return null;
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Optional fields:'),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              width: 90,
                                              child: ElevatedButton(
                                                  onPressed: _pickIcon,
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black
                                                  ),
                                                  child: const Text('Icon',
                                                    style: TextStyle(
                                                      fontSize: 18
                                                    ),
                                                  )
                                              ),
                                            ),
                                            _displayIcon()
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              width: 90,
                                              child: ElevatedButton(
                                                  onPressed: () => _pickColor(context),
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.black
                                                  ),
                                                  child: const Text('Color',
                                                    style: TextStyle(
                                                        fontSize: 18
                                                    ),
                                                  )
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _color
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
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
