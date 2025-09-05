import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/order_items_model.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/view_models/order_v_m.dart';
import 'package:warsha_app/view_models/product_v_m.dart';
import 'package:warsha_app/views/orders/product_widget.dart';

class ProductToAdd extends StatelessWidget {
  const ProductToAdd({super.key});

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
            final name = product.name.toLowerCase() ?? "";
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
                      productId: product.productID,
                      name: product.name,
                      quantity: product.quantity,
                      unitPrice: product.sellingPrice,
                    );

                    final orderVM = Provider.of<OrderVM>(context, listen: false);

                    // Check for duplicates by productId
                    bool alreadyExists = orderVM.orderModel.orderItems
                        .any((item) => item.productId == product.productID);

                    if (!alreadyExists) {
                      orderVM.addToOrderItems = orderItemsModel;
                    } else {
                      orderVM.removeFromOrderItems = orderItemsModel.productId;
                    }
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
