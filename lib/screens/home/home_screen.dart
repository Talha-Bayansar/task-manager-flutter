import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/models/user.dart';
import 'package:task_manager/utillities/shared_prefs.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  HomeScreen({Key? key}) : super(key: key);
  final User user = User.fromJson(
    json.decode(SharedPrefs.instance.getString('user')!),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
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
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
            'You are logged in: ${user.id}, ${user.username}, ${user.email}'),
      ),
    );
  }
}
