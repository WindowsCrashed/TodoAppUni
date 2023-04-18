import 'package:flutter/material.dart';
import 'package:todo_app_uni/widgets/app_drawer.dart';
import 'package:todo_app_uni/widgets/drawer_list_tile.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      drawer: const AppDrawer()
    );
  }
}
