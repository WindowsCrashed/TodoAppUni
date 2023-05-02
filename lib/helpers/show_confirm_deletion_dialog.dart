import 'package:flutter/material.dart';
import 'package:todo_app_uni/widgets/delete_confirm_dialog.dart';

void showConfirmDeletionDialog (
    {
      required BuildContext context,
      required Function onPressed
    })
{
  showDialog(
      context: context,
      builder: (context) => DeleteConfirmDialog(onPressed: onPressed),
      barrierDismissible: false
  );
}