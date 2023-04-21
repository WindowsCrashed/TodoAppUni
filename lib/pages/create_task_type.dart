import 'package:flutter/material.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';

class CreateTaskType extends StatefulWidget {
  const CreateTaskType({Key? key}) : super(key: key);

  @override
  State<CreateTaskType> createState() => _CreateTaskTypeState();
}

class _CreateTaskTypeState extends State<CreateTaskType> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fieldController = TextEditingController();

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
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 70),
                  child: const Text('Create a new task type',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    height: 150,
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
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(fieldController.text))
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                            ),
                            child: const Text('Create',
                              style: TextStyle(
                                fontSize: 20
                              ),
                            )
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
