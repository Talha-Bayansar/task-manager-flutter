import 'package:flutter/material.dart';
import 'package:task_manager/models/subject.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  const SubjectCard({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subject.title,
            style: textTheme.headline5,
          ),
          CircleAvatar(
            backgroundColor: Color(int.parse(subject.color)),
          ),
        ],
      ),
    );
  }
}
