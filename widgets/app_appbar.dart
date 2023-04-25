import 'package:flutter/material.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppAppBar({Key? key, this.title = ''}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
        style: const TextStyle(
            fontSize: 25
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.black,
    );
  }
}
