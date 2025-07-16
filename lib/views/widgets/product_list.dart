import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/view_models/product_v_m.dart';
import 'package:warsha_app/views/widgets/product_widget.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: Provider.of<ProductVM>(context, listen: false).getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ProductWidget(
                  title: snapshot.data![index].productName,
                  description: snapshot.data![index].productDescription,
                  price: snapshot.data![index].productBPrice,
                  category: snapshot.data![index].productCategory,
                  isOutOfStock: true, sku: snapshot.data![index].productSKU,
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