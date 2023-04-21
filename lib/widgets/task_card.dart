import 'package:flutter/material.dart';
import 'package:todo_app_uni/models/task.dart';

class TaskCard extends StatefulWidget {
  final Task task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: SizedBox(
          height: 140,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 54,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.task.name,
                            style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(widget.task.description,
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Chip(
                          label: const Text('stuff'),
                          backgroundColor: Colors.grey[50],
                          labelStyle: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                              color: Colors.black26
                          ),
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.black26)
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 0
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 54,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.task.getDate(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(widget.task.getTime(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(widget.task.priority.priority,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
