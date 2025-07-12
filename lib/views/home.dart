import 'package:flutter/material.dart';
import 'package:warsha_app/views/widgets/app_bar_widget.dart';
import 'package:warsha_app/views/widgets/crud_product.dart';
import 'package:warsha_app/views/widgets/product_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(),
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
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 65, right: 25, bottom: 50),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: CRUDProduct(),
                      ),
                      ProductList(),
                    ],
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
