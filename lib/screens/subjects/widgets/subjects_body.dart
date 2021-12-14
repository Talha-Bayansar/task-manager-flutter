import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/models/subject.dart';
import 'package:task_manager/providers/subject_provider.dart';
import 'package:task_manager/screens/subjects/update_subject/update_subject_screen.dart';
import 'package:task_manager/screens/subjects/widgets/subject_card.dart';

class SubjectsBody extends StatelessWidget {
  const SubjectsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return FutureBuilder(
          future: ref.read(subjectProvider).getSubjects(),
          builder: (context, AsyncSnapshot<List<Subject>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.none:
                return const Center(
                  child: Text('Je hebt geen internet.'),
                );
              case ConnectionState.done:
                List<Subject>? subjects = snapshot.data;
                if (subjects == null) {
                  return const Center(
                    child: Text('Er zijn geen onderwerpen gevonden.'),
                  );
                }
                if (subjects.isEmpty) {
                  return const Center(
                    child: Text('Er zijn geen onderwerpen.'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: subjects.length,
                  itemBuilder: (context, i) => OpenContainer(
                    closedElevation: 0,
                    closedColor: Colors.transparent,
                    closedBuilder: (context, action) =>
                        SubjectCard(subject: subjects[i]),
                    openBuilder: (context, action) =>
                        UpdateSubjectScreen(subject: subjects[i]),
                  ),
                );
            }
          },
        );
      },
    );
  }
}
