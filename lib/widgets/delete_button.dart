import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? onPressed;
  const DeleteButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: const Text('Verwijderen'),
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          const BorderSide(
            color: Colors.red,
          ),
        ),
        foregroundColor: MaterialStateProperty.all(Colors.red),
      ),
    );
  }
}
