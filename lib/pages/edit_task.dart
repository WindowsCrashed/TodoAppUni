import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:todo_app_uni/models/task_priority.dart';
import 'package:todo_app_uni/models/task_type.dart';
import 'package:todo_app_uni/models/task.dart';
import 'package:todo_app_uni/services/task_service.dart';
import 'package:todo_app_uni/services/task_type_service.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/services/task_priority_service.dart';
import 'package:todo_app_uni/widgets/save_cancel_buttons.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();
  final _taskPriorityService = TaskPriorityService();
  final _taskTypeService = TaskTypeService();
  final _taskService = TaskService();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _typesController = TextEditingController();
  final _priorityController = TextEditingController();

  DateTime? _date = DateTime.now();
  TimeOfDay? _time = const TimeOfDay(hour: 0, minute: 0);
  TaskPriority? _priority;
  List<TaskType> _types = [];
  Task? _task;

  void save() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      Map newTask = {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'date': _date,
        'time': _time,
        'priority': _priority,
        'types': _types
      };

      String response = _taskService.editTask(_task!, newTask);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response), duration: const Duration(seconds: 3),)
      );
    }
  }

  void _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101)
    );
    _date = date;
    setState(() {
      if (_date != null) {
        _dateController.text = DateFormat('MM/dd/yyy').format(_date as DateTime);
      } else {
        _dateController.text = '';
      }
    });
  }

  void _pickTime() async {
    TimeOfDay? time = await showTimePicker(
        context: context, initialTime: TimeOfDay.now()
    );
    _time = time;
    setState(() {
      if (_time != null) {
        _timeController.text = _time?.format(context) as String;
      } else {
        _timeController.text = '';
      }
    });
  }

  void _pickPriority(priorityName) {
    TaskPriority? priority = _taskPriorityService.getPriority(priorityName);
    setState(() {
      _priority = priority;
    });
  }

  void _pickTypes(typeNames) {
    List<TaskType> types = [];
    typeNames.forEach((tn) => types.add(_taskTypeService.getType(tn)));
    setState(() {
      _types = types;
    });
  }

  @override void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _typesController.dispose();
    _priorityController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_task == null) {
      _task = (ModalRoute.of(context)!.settings.arguments as Map)['task'];
      _nameController.text = _task!.name;
      _descriptionController.text = _task!.description;
      _dateController.text = _task!.getDate();
      _timeController.text = _task!.getTime();
      _priorityController.text = _task!.priority.priority;

      _date = _task!.date;
      _time = TimeOfDay.fromDateTime(_task!.date);
      _types.addAll(_task!.types as List<TaskType>);
      _priority = _task!.priority;

      // print(_types[0].type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const AppAppBar(title: 'Edit Task'),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 25),
            child: GestureDetector(
              child: Column(
                children: [
                  const Text('Edit a task',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 100),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 420,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required field';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _descriptionController,
                                    minLines: 2,
                                    maxLines: 2,
                                    maxLength: 100,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Description (optional)',
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _dateController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Date',
                                      icon: Icon(Icons.calendar_month,
                                        size: 40,
                                      ),
                                    ),
                                    onTap: _pickDate,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required field';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _timeController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Time',
                                      icon: Icon(Icons.watch_later_outlined,
                                        size: 40,
                                      ),
                                    ),
                                    onTap: _pickTime,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required field';
                                      }
                                      return null;
                                    },
                                  ),
                                  DropdownButtonFormField(
                                    value: _priority == null ? 'Select priority' : _priority?.priority,
                                    items: [
                                      DropdownMenuItem(
                                          value: 'Select priority',
                                          child: Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 10),
                                              child: const Text('Select priority')
                                          )
                                      ),
                                      ..._taskPriorityService.getPriorities()
                                          .map(
                                              (p) => DropdownMenuItem(
                                              value: p.priority,
                                              child: Text(p.priority)
                                          )
                                      ).toList()
                                    ],
                                    onChanged: _pickPriority,
                                    isExpanded: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty
                                          || value == 'Select priority') {
                                        return 'Required field';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                            MultiSelectDialogField(
                              items: _taskTypeService.getTypes().map(
                                      (t) => MultiSelectItem(t.type, t.type)
                              ).toList(),
                              onConfirm: _pickTypes,
                              title: const Text('Select task type(s)'),
                              buttonText: const Text('Select task type(s) (optional)',
                                style: TextStyle(fontSize: 16),
                              ),
                              dialogHeight: 310,
                              initialValue: _types.map((t) => t.type).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50,),
                        SaveCancelButtons(onSave: save, context: context,)
                      ],
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
