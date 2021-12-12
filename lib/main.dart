import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/screens/authentication/login/login_screen.dart';
import 'package:task_manager/screens/home/home_screen.dart';
import 'package:task_manager/screens/subjects/subjects_screen.dart';
import 'package:task_manager/theme/colors.dart';
import 'package:task_manager/utillities/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: kGrey,
        textTheme: const TextTheme(
          button: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      initialRoute:
          SharedPrefs.instance.getString('jwt') != null ? '/' : '/login',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/subjects': (context) => const SubjectsScreen(),
      },
    );
  }
}
