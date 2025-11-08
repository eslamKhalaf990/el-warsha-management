import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceTint,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: Constants.BORDER_RADIUS_50),
        errorStyle: TextStyle(color: Colors.red.shade300),
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Icon(Iconsax.search_normal_copy),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent), borderRadius: Constants.BORDER_RADIUS_50),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: Constants.BORDER_RADIUS_50),
        hintText: title,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      validator: validation,
      onChanged: onChanged,
    );
  }
}