import 'package:flutter/material.dart';

class TaskPriority {
  String priority;
  Color color;
  IconData? icon;

  TaskPriority({required this.priority, this.icon, this.color = Colors.black});
}