import 'package:flutter/material.dart';
import 'package:todo_app_uni/models/task.dart';
import 'package:todo_app_uni/models/task_type.dart';
import 'package:todo_app_uni/widgets/task_type_chip.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final Function setStateCallback;

  const TaskCard({Key? key, required this.task, required this.setStateCallback})
      : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  List<Widget> generateTags(List<TaskType>? types) {
    if (types == null) return [];
    return types.map((t) => TaskTypeChip(label: t.type,)).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: InkWell(
        onTap: () async {
          await Navigator.pushNamed(context, '/view-task', arguments: { 'task': widget.task });
          widget.setStateCallback();
        },
        child: SizedBox(
            height: 135,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 210,
                    child: Column(
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
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(widget.task.description,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: generateTags(widget.task.types),
                          ),
                        )
                      ],
                    ),
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
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(widget.task.priority.icon,
                                color: widget.task.priority.color,
                              ),
                            ),
                            Text(widget.task.priority.priority,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: widget.task.priority.color,
                                  fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ]
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
