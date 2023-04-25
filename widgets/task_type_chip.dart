import 'package:flutter/material.dart';

class TaskTypeChip extends StatelessWidget {
  final String label;

  const TaskTypeChip({Key? key, this.label = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.transparent,
        labelStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 10,
            color: Colors.black26
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
