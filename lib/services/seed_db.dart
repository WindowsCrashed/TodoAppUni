import 'package:flutter/material.dart';
import 'package:todo_app_uni/data/db.dart';
import 'package:todo_app_uni/models/task.dart';
import 'package:todo_app_uni/models/task_type.dart';
import 'package:todo_app_uni/models/task_priority.dart';

void seedDb() {
  List<TaskType> types= [
    TaskType('general'),
    TaskType('cleaning'),
    TaskType('house chores'),
    TaskType('meal')
  ];

  List<TaskPriority> priorities = [
    TaskPriority(priority: 'low', color: Colors.green),
    TaskPriority(priority: 'medium', color: Colors.amber),
    TaskPriority(priority: 'high', color: Colors.red, icon: Icons.warning_amber)
  ];

  List<Task> tasks = [
    Task(
        name: 'Do some stuff',
        priority: priorities[0],
        types: [types[0]],
        date: DateTime(23, 6, 2, 16, 30),
        description: 'Something goes here...'
    ),
    Task(
        name: 'Clean the house',
        priority: priorities[1],
        types: [types[1], types[2]],
        date: DateTime(23, 4, 29, 10, 45),
        description: 'You have to clean the house...'
    ),
    Task(
        name: 'Have lunch',
        priority: priorities[2],
        types: [types[3]],
        date: DateTime(23, 4, 25, 12, 00),
        description: 'You have to eat... now...'
    ),
  ];

  Db.types.addAll(types);
  Db.priorities.addAll(priorities);
  Db.tasks.addAll(tasks);
}