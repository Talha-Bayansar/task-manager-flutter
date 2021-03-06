import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/models/subject.dart';
import 'package:task_manager/providers/subject_provider.dart';
import 'package:task_manager/screens/subjects/subjects_screen.dart';
import 'package:task_manager/widgets/subject_form.dart';
import 'package:task_manager/utillities/extensions.dart';

class UpdateSubjectScreen extends ConsumerStatefulWidget {
  final Subject subject;
  const UpdateSubjectScreen({Key? key, required this.subject})
      : super(key: key);

  @override
  UpdateSubjectScreenState createState() => UpdateSubjectScreenState();
}

class UpdateSubjectScreenState extends ConsumerState<UpdateSubjectScreen> {
  final TextEditingController nameController = TextEditingController();
  Subject? subject;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> handleSubmit(WidgetRef ref, dynamic subjectJson) async {
    if (_formKey.currentState!.validate()) {
      await ref
          .read(subjectProvider)
          .updateSubject(widget.subject.id, subjectJson);
    }
  }

  Future<void> handleDelete() async {
    try {
      await ref.read(subjectProvider).deleteTask(widget.subject.id);
      Navigator.pushNamedAndRemoveUntil(
        context,
        SubjectsScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      throw 'Failed to delete';
    }
  }

  void showDeleteDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text('Ben je zeker dat je dit onderwerp wilt verwijderen?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuleren'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                handleDelete();
              },
              child: const Text('Verwijderen'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    nameController.text = widget.subject.title;
    subject = widget.subject;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onderwerp wijzigen'),
      ),
      body: SubjectForm(
        submitButtonText: 'Wijzigen',
        onDelete: () {
          showDeleteDialog(context);
        },
        nameController: nameController,
        formKey: _formKey,
        initialcolor: Color(int.parse(subject!.color)),
        onSubmit: (Color color) async {
          await handleSubmit(ref, {
            "title": nameController.text,
            "color": color.toHex(),
          });
          Navigator.pushReplacementNamed(
            context,
            SubjectsScreen.routeName,
          );
        },
      ),
    );
  }
}
