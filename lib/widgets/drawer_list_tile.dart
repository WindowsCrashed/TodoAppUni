import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function onTap;

  const DrawerListTile({Key? key, this.title = '', this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
        style: const TextStyle(
            fontSize: 20
        ),
      ),
      onTap: () {
        onTap();
      },
      trailing: Icon(icon),
    );
  }
}
