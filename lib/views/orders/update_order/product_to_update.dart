import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/order_items_model.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/view_models/add_product_v_m.dart';
import 'package:warsha_app/view_models/update_order_v_m.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';

class ProductToUpdate extends StatelessWidget {
  const ProductToUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductVM>(context);

    return FutureBuilder<List<ProductModel>>(
      future: Provider.of<ProductVM>(context).allProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isNotEmpty) {
          final filteredProducts = snapshot.data!.where((product) {
            final name = product.name.toLowerCase();
            final sku = product.sku?.toLowerCase() ?? "";
            final query = Provider.of<ProductVM>(context).searchController.text.toLowerCase();
            return name.contains(query) || sku.contains(query);
          }).toList();
          return Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    final product = filteredProducts[index];

                    OrderItemsModel orderItemsModel = OrderItemsModel(
                      productId: product.id,
                      name: product.name,
                      quantity: product.quantity,
                      unitPrice: product.sellingPrice,
                    );

                    final orderVM = Provider.of<UpdateOrderVM>(context, listen: false);

                    // Check for duplicates by productId
                    // bool alreadyExists = orderVM.orderModel.orderItems
                    //     .any((item) => item.productId == product.id);
                    //
                    // if (!alreadyExists) {
                    //   orderVM.addToOrderItems = orderItemsModel;
                    // } else {
                    //   orderVM.removeFromOrderItems = orderItemsModel.productId;
                    // }
                  },

                  child: ProductWidget(
                    productModel: filteredProducts[index],
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text("no products yet!"),
          );
        }
      },
    );
  }
}



class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        // color: Provider.of<UpdateOrderVM>(context)
        //     .orderModel
        //     .orderItems
        //     .any((product) => product.productId == productModel.id)
        //     ? Theme.of(context).colorScheme.tertiary.withAlpha(30)
        //     : Theme.of(context).colorScheme.onPrimary.withAlpha(100),
        borderRadius: Constants.BORDER_RADIUS_20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceTint,
                  borderRadius: Constants.BORDER_RADIUS_20,
                ),
                child: Image.network(
                  productModel.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  // Show a loading spinner while the image is loading
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  },
                  // Show a fallback if the image fails to load
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Iconsax.shopping_bag,
                      size: 40,
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        DefaultText(txt: productModel.sku!, bold: true),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DefaultText(
                          txt: productModel.name,
                          bold: true,
                        ),

                        const Expanded(child: SizedBox()),

                        // Dot indicator for new
                        if (int.parse(productModel.quantity) < 1)
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red.shade300,
                                borderRadius: Constants.BORDER_RADIUS_20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
                            // margin: const EdgeInsets.only(top: 4, right: 12),
                            child: const DefaultText(
                              txt: 'Out of stock',
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Message
                    Text(
                      productModel.productDescription,
                    ),
                    const SizedBox(height: 6),
                    // Time
                    Row(
                      children: [
                        DefaultText(
                          txt: "${productModel.category}    |  ",
                          size: 14,
                        ),
                        DefaultText(
                          txt: " ${productModel.quantity} Pieces",
                          size: 14,
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: Constants.BORDER_RADIUS_20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                width: 200,
                child: Row(
                  children: [
                    const DefaultText(
                        txt: "Buying Price  ", size: 14, color: Colors.white),
                    DefaultText(
                        txt: "${productModel.buyingPrice} EGP", size: 14, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: Constants.BORDER_RADIUS_20),
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: Row(
                  children: [
                    const DefaultText(
                        txt: "Selling Price  ", size: 14, color: Colors.white),
                    DefaultText(
                        txt: "${productModel.sellingPrice} EGP", size: 14, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Divider(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}

