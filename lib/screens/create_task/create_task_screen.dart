import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/models/subject.dart';
import 'package:task_manager/providers/subject_provider.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/screens/home/home_screen.dart';
import 'package:task_manager/utillities/date_formatter.dart';
import 'package:task_manager/widgets/custom_text_field.dart';
import 'package:task_manager/widgets/submit_button.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  CreateTaskScreenState createState() => CreateTaskScreenState();
}

class CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController descriptionController = TextEditingController();
  List<Subject> subjects = [];
  Subject? selectedSubject;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> initSubjects() async {
    List<Subject> fetchedSubjects =
        await ref.read(subjectProvider).getSubjects();
    setState(() {
      subjects = fetchedSubjects;
      selectedSubject = subjects[0];
    });
  }

  @override
  void initState() {
    initSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nieuwe taak"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(
              height: 40,
            ),
            DropdownButton<Subject>(
              value: selectedSubject,
              onChanged: (Subject? newSubject) {
                setState(() {
                  selectedSubject = newSubject;
                });
              },
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
              label: "Description",
              controller: descriptionController,
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () async {
                await _selectDate(context);
              },
              child: const Text('Selecteer datum'),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () async {
                await _selectTime(context);
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
              title: 'Aanmaken',
              onPressed: () async {
                try {
                  await ref.read(taskProvider).createTask({
                    'description': descriptionController.text,
                    'subject': selectedSubject!.id,
                    'deadline': selectedDateTime.toIso8601String(),
                  });
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeScreen.routeName,
                    (route) => false,
                  );
                } catch (e) {
                  throw 'Failed to create task';
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
