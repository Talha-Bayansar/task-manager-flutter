import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/models/subject.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/providers/subject_provider.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/screens/home/home_screen.dart';
import 'package:task_manager/widgets/task_form.dart';

class UpdateTaskScreen extends ConsumerStatefulWidget {
  final Task task;
  const UpdateTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  UpdateTaskScreenState createState() => UpdateTaskScreenState();
}

class UpdateTaskScreenState extends ConsumerState<UpdateTaskScreen> {
  final TextEditingController descriptionController = TextEditingController();
  List<Subject> subjects = [];
  Subject? selectedSubject;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDateTime = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
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

  Future<void> selectTime(BuildContext context) async {
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

  void handleChangeSubject(Subject? newSubject) {
    setState(() {
      selectedSubject = newSubject;
    });
  }

  Future<void> handleSubmit() async {
    try {
      await ref.read(taskProvider).updateTask(widget.task.id, {
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
      throw 'Failed to update task';
    }
  }

  Future<void> initSubjects() async {
    List<Subject> fetchedSubjects =
        await ref.read(subjectProvider).getSubjects();
    setState(() {
      subjects = fetchedSubjects;
      selectedSubject = subjects
          .firstWhere((subject) => subject.id == widget.task.subject.id);
    });
  }

  @override
  void initState() {
    initSubjects();
    descriptionController.text = widget.task.description;
    setState(() {
      DateTime deadline = DateTime.parse(widget.task.deadline);
      selectedTime = TimeOfDay.fromDateTime(deadline);
      selectedDate = deadline;
      selectedDateTime = deadline;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taak wijzigen"),
      ),
      body: TaskForm(
        descriptionController: descriptionController,
        onChangedSubject: handleChangeSubject,
        onSubmit: handleSubmit,
        selectDate: selectDate,
        selectTime: selectTime,
        selectedDateTime: selectedDateTime,
        selectedSubject: selectedSubject,
        subjects: subjects,
        submitButtonText: 'Wijzigen',
      ),
    );
  }
}
