import 'package:flutter/material.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/widgets/app_drawer.dart';
import 'package:todo_app_uni/widgets/task_card.dart';
import 'package:todo_app_uni/services/task_service.dart';
import 'package:todo_app_uni/widgets/task_card_alt.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _taskService = TaskService();

  bool _isChecking = false;

  Widget _setTaskCard(task) {
    if (_isChecking) {
      return TaskCardAlt(task: task, setStateCallback: () => setState((){}),);
    } else {
      return TaskCard(task: task);
    }
  }

  IconData _setIcon() => _isChecking ? Icons.list : Icons.checklist_rtl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Just do it!'),
      backgroundColor: Colors.grey[200],
      drawer: AppDrawer(setStateCallback: () => setState((){}),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => setState(() {
          _isChecking = !_isChecking;
        }),
        child: Icon(_setIcon(), size: 28,),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        children: _taskService.getTasks().map((t) => _setTaskCard(t)).toList(),
      ),
    );
  }
}
