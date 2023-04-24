import 'package:flutter/material.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/widgets/app_drawer.dart';
import 'package:todo_app_uni/widgets/task_card.dart';
import 'package:todo_app_uni/services/task_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Just do it!'),
      backgroundColor: Colors.grey[200],
      drawer: const AppDrawer(),
      onDrawerChanged: (value) { setState(() {}); },
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        children: _taskService.getTasks().map((t) => TaskCard(task: t)).toList(),
      ),
    );
  }
}
