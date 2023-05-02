import 'package:flutter/material.dart';
import 'package:todo_app_uni/pages/create_task.dart';
import 'package:todo_app_uni/pages/create_task_priority.dart';
import 'package:todo_app_uni/pages/create_task_type.dart';
import 'package:todo_app_uni/pages/edit_task.dart';
import 'package:todo_app_uni/pages/edit_task_priority.dart';
import 'package:todo_app_uni/pages/edit_task_type.dart';
import 'package:todo_app_uni/pages/home.dart';
import 'package:todo_app_uni/pages/list_task_priorities.dart';
import 'package:todo_app_uni/pages/list_task_types.dart';
import 'package:todo_app_uni/pages/view_task.dart';
import 'package:todo_app_uni/services/seed_db.dart';

void main() {
  seedDb();

  runApp(MaterialApp(
    title: 'JustDoIi!',
    initialRoute: '/home',
    routes: {
      '/home': (context) => const Home(),
      '/create-task-type': (context) => const CreateTaskType(),
      '/create-task-priority': (context) => const CreateTaskPriority(),
      '/create-task': (context) => const CreateTask(),
      '/view-task': (context) => const ViewTask(),
      '/list-task-types': (context) => const ListTaskTypes(),
      '/list-task-priorities': (context) => const ListTaskPriorities(),
      '/edit-task-type': (context) => const EditTaskType(),
      '/edit-task-priority': (context) => const EditTaskPriority(),
      '/edit-task': (context) => const EditTask()
    },
    debugShowCheckedModeBanner: false,
  ));
}