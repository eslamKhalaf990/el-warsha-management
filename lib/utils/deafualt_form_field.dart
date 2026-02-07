import 'package:flutter/material.dart';

import 'const_values.dart';

class DefaultForm extends StatelessWidget {
  const DefaultForm({super.key, required this.title, required this.controller, this.validation, required this.numberOfLines, this.onChanged});
  final String title;
  final int numberOfLines;
  final TextEditingController controller;
  final String? Function(String?)? validation;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Theme.of(context).colorScheme.tertiary.withAlpha(Constants.OPACITY_05),
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      validator: validation,
      onChanged: onChanged,
    );
  }
}