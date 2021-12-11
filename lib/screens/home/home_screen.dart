import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/models/user.dart';
import 'package:task_manager/screens/home/screens/create_task/create_task_screen.dart';
import 'package:task_manager/screens/home/screens/tasks_done/tasks_done_screen.dart';
import 'package:task_manager/screens/home/screens/tasks_today/tasks_today_screen.dart';
import 'package:task_manager/screens/home/screens/tasks_upcoming/tasks_upcoming_screen.dart';
import 'package:task_manager/utillities/shared_prefs.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User user = User.fromJson(
    json.decode(SharedPrefs.instance.getString('user')!),
  );

  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Map<String, dynamic>> bottomNavigationItems = [
    {
      'name': "Vandaag",
      'icon': Icons.today,
    },
    {
      'name': "Komend",
      'icon': Icons.date_range,
    },
    {
      'name': "Klaar",
      'icon': Icons.event_available,
    },
  ];

  final List<Widget> screens = const [
    TasksTodayScreen(),
    TasksUpcomingScreen(),
    TasksDoneScreen(),
  ];

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
        title: Text('Welkom ${user.username}'),
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
        openBuilder: (context, action) => const CreateTaskScreen(),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
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
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item['icon']),
                label: item['name'],
              ),
            )
            .toList(),
      ),
    );
  }
}
