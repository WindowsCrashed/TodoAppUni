import 'package:flutter/material.dart';
import 'package:todo_app_uni/widgets/app_appbar.dart';
import 'package:todo_app_uni/widgets/app_drawer.dart';
import 'package:todo_app_uni/widgets/task_card.dart';
import 'package:todo_app_uni/data/db.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Just do it!'),
      backgroundColor: Colors.grey[200],
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        children: Db.tasks.map((t) => TaskCard(task: t)).toList(),
      ),
    );
  }
}
