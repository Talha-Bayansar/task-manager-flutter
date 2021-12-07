import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/utillities/date_formatter.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(
        16,
      ),
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
        color: Color(
          int.parse('0xff${int.parse(task.subject.color)}'),
        ),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                label: Text(task.subject.title),
                backgroundColor: Colors.transparent,
              ),
              Text(task.description),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormatter.getDate(task.deadline),
                  ),
                  Text(
                    DateFormatter.getTime(task.deadline),
                  ),
                ],
              ),
            ],
          ),
          Column(),
        ],
      ),
    );
  }
}
