import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/utillities/date_formatter.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text(task.subject.title),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(task.description),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormatter.getDate(task.deadline),
                      style: textTheme.caption,
                    ),
                    Text(
                      DateFormatter.getTime(task.deadline),
                      style: textTheme.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                splashRadius: 20,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check),
                splashRadius: 20,
                color: task.isChecked == true ? Colors.green : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
