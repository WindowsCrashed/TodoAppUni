import 'package:flutter/material.dart';
import 'package:todo_app_uni/pages/create_task_type.dart';
import 'package:todo_app_uni/pages/home.dart';
import 'package:todo_app_uni/services/seed_db.dart';

void main() {
  seedDb();

  runApp(MaterialApp(
    title: 'JustDoIi!',
    initialRoute: '/home',
    routes: {
      '/home': (context) => const Home(),
      '/create-task-type': (context) => const CreateTaskType(),
    },
    debugShowCheckedModeBanner: false,
  ));
}