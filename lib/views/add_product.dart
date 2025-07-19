import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/product_v_m.dart';

import 'widgets/drag_drop_widget.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productDescription = TextEditingController();
  final TextEditingController _productBuyingPrice = TextEditingController();
  final TextEditingController _productSellingPrice = TextEditingController();
  final TextEditingController _productCategory = TextEditingController();
  final TextEditingController _productQuantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const DefaultText(txt: "Add New Product")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade50.withOpacity(0.3), Colors.blue.shade50.withOpacity(0.7)],
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
                // width: 600,
                child: Column(
                  children: [
                    const DragDropImageUpload(),
                    DefaultButton(onTap: (){}, title: "title", margin: EdgeInsets.all(0))
                  ],
                )
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
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product name",
                              controller: _productName,
                              icon: Iconsax.bag,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product description",
                              controller: _productDescription,
                              icon: Iconsax.document,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product buying price",
                              controller: _productBuyingPrice,
                              icon: Iconsax.money,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product selling price",
                              controller: _productSellingPrice,
                              icon: Iconsax.money,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product category",
                              controller: _productCategory,
                              icon: Iconsax.category,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: DefaultProductForm(
                              title: "Product quantity",
                              controller: _productQuantity,
                              icon: Iconsax.add,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Consumer<ProductVM>(
                          builder: (context, productVM, child) => DefaultButton(
                            onTap: () async {
                              String status = await productVM.addProduct(
                                _productName.text,
                                _productDescription.text,
                                _productBuyingPrice.text,
                                _productSellingPrice.text,
                                _productCategory.text,
                                _productQuantity.text,
                              );
                              if (status == "product_added") {
                                Navigator.pop(context);
                                productVM.initAllProducts();
                                productVM.getAllProducts();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Product added successfully"),
                                  ),
                                );
                              }
                            },
                            title: "Add new product",
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                        ),
                        const SizedBox(height: 20),
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
  const DefaultProductForm({super.key, required this.title, required this.icon, required this.controller});
  final String title;
  final TextEditingController controller;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
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
