import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/screens/home/widgets/task_card.dart';

class TasksUpcomingScreen extends StatelessWidget {
  const TasksUpcomingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return FutureBuilder(
          future: ref.read(taskProvider).getTasksUpcoming(),
          builder: (context, AsyncSnapshot<List<Task>> snapshot) {
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
                List<Task>? tasks = snapshot.data;
                if (tasks == null) {
                  return const Center(
                    child: Text(
                        'Er zijn geen taken gevonden voor de komende dagen.'),
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, i) => TaskCard(task: tasks[i]),
                );
            }
          },
        );
      },
    );
  }
}
