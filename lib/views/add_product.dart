import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const DefaultText(txt: "Add New Product")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade50.withOpacity(0.3),
              Colors.blue.shade50.withOpacity(0.7)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: Constants.BORDER_RADIUS_15,
                ),
                width: 600,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, right: 15, left: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: Constants.BORDER_RADIUS_15,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product name",
                              icon: Iconsax.bag,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product description",
                              icon: Iconsax.document,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product buying price",
                              icon: Iconsax.money,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultProductForm(
                                title: "Product selling price",
                                icon: Iconsax.money,
                              ),
                            ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product category",
                              icon: Iconsax.category,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product quantity",
                              icon: Iconsax.add,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultProductForm extends StatelessWidget {
  const DefaultProductForm({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController(),
      cursorColor: Theme.of(context).colorScheme.tertiary.withAlpha(Constants.OPACITY_05),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceTint,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: Constants.BORDER_RADIUS_15),
        errorStyle: TextStyle(color: Colors.red.shade300),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Icon(icon, color: Theme.of(context).colorScheme.secondary,),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: Constants.BORDER_RADIUS_15),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: Constants.BORDER_RADIUS_15),
        hintText: title,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
