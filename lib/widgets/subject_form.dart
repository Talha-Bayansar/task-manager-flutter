import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:task_manager/widgets/custom_text_field.dart';
import 'package:task_manager/widgets/submit_button.dart';

class SubjectForm extends StatefulWidget {
  final TextEditingController nameController;
  final Key formKey;
  final void Function(Color color)? onSubmit;
  const SubjectForm({
    Key? key,
    required this.nameController,
    required this.formKey,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<SubjectForm> createState() => _SubjectFormState();
}

class _SubjectFormState extends State<SubjectForm> {
  Color selectedColor = const Color(0xff443a49);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(
            height: 40,
          ),
          CustomTextField(
            label: 'Naam',
            controller: widget.nameController,
          ),
          const SizedBox(
            height: 20,
          ),
          ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SubmitButton(
            title: 'Aanmaken',
            onPressed: () {
              widget.onSubmit!(selectedColor);
            },
          ),
        ],
      ),
    );
  }
}
