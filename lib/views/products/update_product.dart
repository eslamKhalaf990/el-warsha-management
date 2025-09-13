import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/drag_drop_controller.dart';
import 'package:warsha_app/controllers/update_drag_drop.dart';
import 'package:warsha_app/controllers/update_order/update_product.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/add_product_v_m.dart';
import 'package:warsha_app/view_models/update_product_v_m.dart';
import 'package:warsha_app/views/products/update_drag_drop.dart';

class UpdateProduct extends StatelessWidget {
  const UpdateProduct({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<UpdateProductProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      productProvider.loadProduct(productModel);
    });

    return Consumer<UpdateProductProvider>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const DefaultText(txt: "Update Product"),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade50,
                Colors.yellow.shade200
              ], // Replace with your colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 50, left: 15),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: Constants.BORDER_RADIUS_15,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Expanded(
                            flex: 3,
                            child: UpdateDragDropImageUpload(productImage: productModel.image,),
                          ),
                          Container(
                            margin: const EdgeInsets.all(15),
                            child: const Row(
                              children: [DefaultText(txt: "Product Pricing")],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: DefaultProductForm(
                                    title: "Product buying price",
                                    controller: value.productBuyingPrice,
                                    onChange: value.updateBuyingPrice,
                                    icon: null,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: DefaultProductForm(
                                    title: "Product selling price",
                                    controller: value.productSellingPrice,
                                    onChange: value.updateSellingPrice,
                                    icon: null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultProductForm(
                                title: "Discount by EGP",
                                controller: value.discount,
                                icon: Iconsax.discount_shape,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 50, right: 15, left: 15),
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [DefaultText(txt: "Product Details")],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultProductForm(
                                title: "Product name",
                                controller: value.productName,
                                icon: Iconsax.bag,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultProductForm(
                                title: "Product description",
                                controller: value.productDescription,
                                icon: Iconsax.document,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultProductForm(
                                title: "Product category",
                                controller: value.productCategory,
                                icon: Iconsax.category,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultProductForm(
                                title: "Product quantity",
                                controller: value.productQuantity,
                                icon: Iconsax.add,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Consumer<UpdateProductVM>(
                                builder: (context, productVM, child) =>
                                    Expanded(
                                  flex: 3,
                                  child: DefaultButton(
                                    onTap: () async {
                                      String status =
                                          await productVM.updateProduct(
                                        productName: value.productName.text,
                                        productDescription:
                                            value.productDescription.text,
                                        productBPrice:
                                            value.productBuyingPrice.text,
                                        productSPrice:
                                            value.productSellingPrice.text,
                                        productCategory:
                                            value.productCategory.text,
                                        productQuantity:
                                            value.productQuantity.text,
                                        imageBytes:
                                            Provider.of<UpdateDragDropController>(
                                                    context,
                                                    listen: false)
                                                .droppedBytes, id: productModel.id,
                                      );
                                      if (status == "product_updated") {
                                        Navigator.pop(context);
                                        Provider.of<ProductVM>(context, listen: false).initAllProducts();
                                        Provider.of<ProductVM>(context, listen: false).getAllProducts();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Product updated successfully"),
                                          ),
                                        );
                                      }
                                      debugPrint("Product Name: ${value.productName.text}");
                                      debugPrint("Description: ${value.productDescription.text}");
                                      debugPrint("Buying Price: ${value.productBuyingPrice.text}");
                                      debugPrint("Selling Price: ${value.productSellingPrice.text}");
                                      debugPrint("Category: ${value.productCategory.text}");
                                      debugPrint("Quantity: ${value.productQuantity.text}");
                                      debugPrint("Image Bytes: ${Provider.of<DragDropController>(context, listen: false).droppedBytes?.length ?? 0} bytes");
                                    },
                                    isValid: !Provider.of<UpdateProductVM>(context)
                                        .isLoading,
                                    isLoading: Provider.of<UpdateProductVM>(context)
                                        .isLoading,
                                    title: "Update product",
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceTint,
                                    borderRadius: Constants.BORDER_RADIUS_20,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15),
                                  child: Row(
                                    children: [
                                      const DefaultText(
                                          txt: "Profit Margin is:  "),
                                      DefaultText(
                                        txt:
                                            "${value.sellingPrice - value.buyingPrice}",
                                        bold: true,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
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
      ),
    );
  }
}

class DefaultProductForm extends StatelessWidget {
  const DefaultProductForm({
    super.key,
    required this.title,
    required this.icon,
    required this.controller,
    this.onChange,
    this.fillColor, this.currency,
  });
  final String title;
  final TextEditingController controller;
  final Function(String)? onChange;
  final IconData? icon;
  final bool? currency;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      cursorColor: Theme.of(context)
          .colorScheme
          .tertiary
          .withAlpha(Constants.OPACITY_05),
      decoration: InputDecoration(
        filled: true,
        fillColor:fillColor ?? Theme.of(context).colorScheme.surfaceTint,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: Constants.BORDER_RADIUS_15),
        errorStyle: TextStyle(color: Colors.red.shade300),
        prefixIcon: icon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : null,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: Constants.BORDER_RADIUS_15),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: Constants.BORDER_RADIUS_15),
        suffix: currency !=  null ? const DefaultText(txt: "EGP") : null,
        labelText: title,
        labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
