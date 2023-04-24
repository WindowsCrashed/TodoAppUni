import 'package:flutter/material.dart';
import 'package:todo_app_uni/pages/create_task.dart';
import 'package:todo_app_uni/pages/create_task_priority.dart';
import 'package:todo_app_uni/pages/create_task_type.dart';
import 'package:todo_app_uni/pages/home.dart';
import 'package:todo_app_uni/services/seed_db.dart';

void main() {
  seedDb();

  runApp(MaterialApp(
    title: 'JustDoIi!',
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/create-task-type': (context) => const CreateTaskType(),
      '/create-task-priority': (context) => const CreateTaskPriority(),
      '/create-task': (context) => const CreateTask()
    },
    debugShowCheckedModeBanner: false,
  ));
}