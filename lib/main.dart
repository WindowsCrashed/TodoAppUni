import 'package:flutter/material.dart';
import 'package:todo_app_uni/pages/home.dart';
import 'package:todo_app_uni/services/seed_db.dart';

void main() {
  seedDb();

  runApp(const MaterialApp(
    title: 'JustDoIi!',
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}