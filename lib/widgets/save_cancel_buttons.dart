import 'package:flutter/material.dart';

class SaveCancelButtons extends StatelessWidget {
  final Function onSave;
  final BuildContext context;

  const SaveCancelButtons({Key? key, required this.onSave, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
            width: 210,
            child: ElevatedButton(
                onPressed: () => onSave(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                ),
                child: const Text('Save',
                  style: TextStyle(
                      fontSize: 20
                  ),
                )
            ),
          ),
          SizedBox(
            height: 50,
            width: 210,
            child: OutlinedButton(
                onPressed: () => Navigator.pop(this.context),
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black54,
                    side: const BorderSide(width: 2, color: Colors.black54)
                ),
                child: const Text('Cancel',
                  style: TextStyle(
                      fontSize: 20
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
