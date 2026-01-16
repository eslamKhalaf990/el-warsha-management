import 'package:flutter/material.dart';
import 'package:warsha_app/views/products/crud_product.dart';
import 'package:warsha_app/views/products/product_list.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: CRUDProduct(),
          ),
          ProductList(),
        ],
      ),
    );
  }
}
