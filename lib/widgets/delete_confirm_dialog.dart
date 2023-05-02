import 'package:flutter/material.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final Function onPressed;

  const DeleteConfirmDialog({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Item'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
            onPressed: () => onPressed(),
            child: const Text('Delete',
              style: TextStyle(
                fontSize: 18
              ),
            )
        ),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
              style: TextStyle(
                  fontSize: 18
              ),
            )
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
