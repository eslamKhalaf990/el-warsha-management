import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/deafualt_form_field.dart';
import 'package:warsha_app/utils/default_text.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DefaultText(txt: "Add New Product")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade50.withOpacity(0.3),
              Colors.blue.shade50.withOpacity(0.7)
            ], // Replace with your colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Row(
          children: [
            Expanded(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: DefaultProductForm(),
            )),
            Expanded(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: DefaultProductForm(),
            )),
          ],
        ),
      ),

    );
  }
}

class DefaultProductForm extends StatelessWidget {
  const DefaultProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController(),
      cursorColor: Theme.of(context).colorScheme.tertiary.withAlpha(Constants.OPACITY_05),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: Constants.BORDER_RADIUS_20),
        errorStyle: TextStyle(color: Colors.red.shade300),
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Icon(Iconsax.search_normal_copy),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent), borderRadius: Constants.BORDER_RADIUS_20),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: Constants.BORDER_RADIUS_20),
        hintText: "Product name",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
