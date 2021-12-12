import 'package:task_manager/models/subject.dart';

class Task {
  final String id, description, deadline;
  bool isChecked;
  final Subject subject;

  Task({
    required this.id,
    required this.description,
    required this.deadline,
    required this.isChecked,
    required this.subject,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      description: json['description'],
      isChecked: json['isChecked'],
      deadline: json['deadline'],
      subject: Subject.fromJson(json['subject']),
    );
  }

  Map<String, dynamic> toJsonDto() => {
        'description': description,
        'deadline': deadline,
        'subject': subject.id,
        'isChecked': isChecked,
      };
}
