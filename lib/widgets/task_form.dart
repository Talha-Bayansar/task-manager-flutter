import 'package:flutter/material.dart';
import 'package:task_manager/models/subject.dart';
import 'package:task_manager/utillities/date_formatter.dart';
import 'package:task_manager/widgets/custom_text_field.dart';
import 'package:task_manager/widgets/submit_button.dart';

class TaskForm extends StatelessWidget {
  final Subject? selectedSubject;
  final void Function(Subject?)? onChangedSubject;
  final List<Subject> subjects;
  final TextEditingController descriptionController;
  final Function selectTime;
  final Function selectDate;
  final DateTime selectedDateTime;
  final String submitButtonText;
  final void Function()? onSubmit;
  const TaskForm({
    Key? key,
    required this.descriptionController,
    required this.onChangedSubject,
    required this.onSubmit,
    required this.selectDate,
    required this.selectTime,
    required this.selectedDateTime,
    required this.selectedSubject,
    required this.subjects,
    required this.submitButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(
            height: 40,
          ),
          DropdownButton<Subject>(
            value: selectedSubject,
            onChanged: onChangedSubject,
            borderRadius: BorderRadius.circular(16),
            isExpanded: true,
            items: subjects
                .map(
                  (subject) => DropdownMenuItem<Subject>(
                    child: Text(subject.title),
                    value: subject,
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: "Beschrijving",
            controller: descriptionController,
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            onPressed: () async {
              await selectDate(context);
            },
            child: const Text('Selecteer datum'),
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            onPressed: () async {
              await selectTime(context);
            },
            child: const Text('Selecteer tijd'),
          ),
          Text(
            DateFormatter.getDateTime(
              selectedDateTime.toIso8601String(),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          SubmitButton(
            title: submitButtonText,
            onPressed: onSubmit,
          )
        ],
      ),
    );
  }
}
