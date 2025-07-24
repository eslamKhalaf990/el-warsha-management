import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/view_models/product_v_m.dart';
import 'package:warsha_app/views/widgets/app_bar_widget.dart';
import 'package:warsha_app/views/widgets/crud_product.dart';
import 'package:warsha_app/views/widgets/product_list.dart';

import '../utils/default_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductVM>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(),
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
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 65, right: 25, bottom: 50),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  // color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                                  borderRadius: Constants.BORDER_RADIUS_20
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              child: Row(
                                children: [
                                  Icon(Iconsax.home, color: Theme.of(context).colorScheme.secondary,),
                                  const SizedBox(
                                      width: 15
                                  ),
                                  const DefaultText(txt: "Home", bold: true,)
                                ],
                              ),
                            ),
                            // const SizedBox(height: 70),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                                borderRadius: Constants.BORDER_RADIUS_20
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.category,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 15),
                                  const DefaultText(txt: "Products", bold: true,)
                                ],
                              ),
                            ),
                            // const SizedBox(height: 70),
                            Container(
                              decoration: BoxDecoration(
                                  // color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                                  borderRadius: Constants.BORDER_RADIUS_20
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.house,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const DefaultText(txt: "Inventory", bold: true,)
                                ],
                              ),
                            ),
                            // const SizedBox(height: 70),
                            Container(
                              decoration: BoxDecoration(
                                  // color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                                  borderRadius: Constants.BORDER_RADIUS_20
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.profile_2user,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 15),
                                  const DefaultText(txt: "Customers", bold: true,)
                                ],
                              ),
                            ),
                            // const SizedBox(height: 70),
                            Container(
                              decoration: BoxDecoration(
                                  // color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                                  borderRadius: Constants.BORDER_RADIUS_20
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.document,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 15),
                                  const DefaultText(txt: "Invoices", bold: true,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      flex: 4,
                      child: Container(
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
