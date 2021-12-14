import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/home/home_screen.dart';
import 'package:task_manager/screens/subjects/create_subject/create_subject.dart';
import 'package:task_manager/screens/subjects/widgets/subjects_body.dart';
import 'package:task_manager/utillities/shared_prefs.dart';

class SubjectsScreen extends StatelessWidget {
  static const routeName = '/subjects';
  const SubjectsScreen({Key? key}) : super(key: key);

  void showLogoutDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ben je zeker dat je wilt uitloggen?'),
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
                SharedPrefs.instance.remove('jwt');
                SharedPrefs.instance.remove('user');
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Uitloggen'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onderwerpen'),
        actions: [
          IconButton(
            onPressed: () {
              showLogoutDialog(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: OpenContainer(
        closedShape: const CircleBorder(),
        closedBuilder: (context, action) => FloatingActionButton(
          onPressed: () {
            action.call();
          },
          child: const Icon(Icons.add),
        ),
        openBuilder: (context, action) => CreateSubjectScreen(),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              title: const Text('Taken'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              title: const Text('Onderwerpen'),
            ),
          ],
        ),
      ),
      body: const SubjectsBody(),
    );
  }
}
