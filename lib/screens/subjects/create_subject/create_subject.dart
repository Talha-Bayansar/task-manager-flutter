import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/providers/subject_provider.dart';
import 'package:task_manager/screens/subjects/subjects_screen.dart';
import 'package:task_manager/widgets/subject_form.dart';
import 'package:task_manager/utillities/extensions.dart';

class CreateSubjectScreen extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CreateSubjectScreen({Key? key}) : super(key: key);

  Future<void> handleSubmit(WidgetRef ref, dynamic subjectJson) async {
    if (_formKey.currentState!.validate()) {
      await ref.read(subjectProvider).createSubject(subjectJson);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onderwerp aanmaken'),
      ),
      body: SubjectForm(
        nameController: nameController,
        formKey: _formKey,
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
