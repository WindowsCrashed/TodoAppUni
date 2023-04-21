import 'package:flutter/material.dart';
import 'package:todo_app_uni/models/task_priority.dart';
import 'package:todo_app_uni/models/task_type.dart';
import 'package:todo_app_uni/widgets/app_drawer.dart';
import 'package:todo_app_uni/widgets/task_card.dart';

import '../models/task.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = [
      Task(
          name: 'Do some stuff',
          priority: TaskPriority(priority: 'low', color: Colors.green),
          types: [TaskType('general')],
          date: DateTime.now(),
          description: 'Something goes here...'
      ),
      Task(
          name: 'Clean the house',
          priority: TaskPriority(priority: 'medium', color: Colors.yellow.shade600),
          types: [TaskType('cleaning'), TaskType('house chores')],
          date: DateTime.now(),
          description: 'You have to clean the house...'
      ),
      Task(
          name: 'Have lunch',
          priority: TaskPriority(priority: 'high', color: Colors.red, icon: Icons.warning_amber),
          types: [TaskType('meal')],
          date: DateTime.now(),
          description: 'You have to eat... now...'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Just do it!',
          style: TextStyle(
            fontSize: 25
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[200],
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        children: [
          TaskCard(task: tasks[0],),
          TaskCard(task: tasks[1],),
          TaskCard(task: tasks[2],),
        ],
      ),
    );
  }
}
