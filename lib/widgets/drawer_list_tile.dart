import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData? icon;

  const DrawerListTile({Key? key, this.title = '', this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
        style: const TextStyle(
            fontSize: 20
        ),
      ),
      onTap: () {},
      trailing: Icon(icon),
    );
  }
}
