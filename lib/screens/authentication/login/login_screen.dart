import 'package:flutter/material.dart';
import 'package:task_manager/screens/authentication/login/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Aanmelden'),
            automaticallyImplyLeading: false,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                'Welkom bij Task Manager.',
                style: textTheme.headline5,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Meld je aan om je taken te beheren.',
                style: textTheme.subtitle1,
              ),
              const SizedBox(
                height: 60,
              ),
              LoginForm(),
            ],
          )),
    );
  }
}
