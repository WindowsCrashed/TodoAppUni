import 'package:flutter/material.dart';
import 'package:todo_app_uni/widgets/app_drawer_section_divider.dart';
import 'drawer_list_tile.dart';

class AppDrawer extends StatelessWidget {
  final Function setStateCallback;

  const AppDrawer({Key? key, required this.setStateCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                color: Colors.black
            ),
            child: Center(
              child: Text('Just do it!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30
                ),
              ),
            ),
          ),
          const AppDrawerSectionDivider(label: 'Visualization'),
          DrawerListTile(
              title: 'Task types',
              icon: Icons.task,
              onTap: () => Navigator.pushNamed(context, '/list-task-types')
          ),
          DrawerListTile(
              title: 'Task priorities',
              icon: Icons.priority_high,
              onTap: () => Navigator.pushNamed(context, '/list-task-priorities')
          ),
          const AppDrawerSectionDivider(label: 'Creation'),
          DrawerListTile(
            title: 'Create task',
            icon: Icons.task_alt,
            onTap: () async {
              await Navigator.pushNamed(context, '/create-task');
              setStateCallback();
            },
          ),
          DrawerListTile(
            title: 'Create task type',
            icon: Icons.task,
            onTap: () => Navigator.pushNamed(context, '/create-task-type'),
          ),
          DrawerListTile(
            title: 'Create priority',
            icon: Icons.priority_high,
            onTap: () => Navigator.pushNamed(context, '/create-task-priority'),
          ),
        ],
      ),
    );
  }
}
