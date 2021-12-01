import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/providers/user_provider.dart';
import 'package:task_manager/widgets/custom_text_field.dart';
import 'package:task_manager/widgets/submit_button.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? validateEmail(String? value) {
    if (value!.isNotEmpty) {
      if (!EmailValidator.validate(value)) {
        return 'Vul een geldig emailadres in.';
      }
    } else {
      return 'Vul een geldig emailadres in.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: 'Emailadres',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: 'Paswoord',
            obscureText: true,
            controller: _passwordController,
            validator: (value) {
              if (value!.length < 6) {
                return 'Je paswoord moet minstens 6 karakters bevatten.';
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Consumer(
            builder: (context, ref, child) {
              return SubmitButton(
                title: 'Aanmelden',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Aan het aanmelden..."),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    try {
                      await ref.read(userProvider).signIn(
                          _emailController.text, _passwordController.text);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Je hebt niet kunnen aanmelden. Probeer het opnieuw."),
                        ),
                      );
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
