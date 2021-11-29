import 'package:flutter/material.dart';
import 'package:task_manager/screens/authentication/login/login_screen.dart';
import 'package:task_manager/screens/home/home_screen.dart';
import 'package:task_manager/utillities/shared_prefs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          SharedPrefs.instance.getString('jwt') != null ? '/' : '/login',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
