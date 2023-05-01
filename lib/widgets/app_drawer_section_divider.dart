import 'package:flutter/material.dart';

class AppDrawerSectionDivider extends StatelessWidget {
  final String label;

  const AppDrawerSectionDivider({Key? key, this.label = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Divider(
                  color: Colors.black45,
                  thickness: 2,
                ),
              ),
            ),
            Text(label,
              style: const TextStyle(
                  fontSize: 22,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Divider(
                  color: Colors.black45,
                  thickness: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
