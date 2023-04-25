import 'package:flutter/material.dart';

class TaskTypeChipBig extends StatelessWidget {
  final String label;

  const TaskTypeChipBig({Key? key, this.label = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.black,
        labelStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
            color: Colors.white
        ),
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.black26)
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 2, vertical: 0
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
