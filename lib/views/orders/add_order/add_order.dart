import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/add_order/add_customer.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/deafualt_form_field.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';
import 'package:warsha_app/view_models/add_product_v_m.dart';
import 'package:warsha_app/views/orders/add_order/order_details.dart';
import 'package:warsha_app/views/orders/add_order/customer_to_add.dart';
import 'package:warsha_app/views/orders/add_order/product_to_add.dart';

class AddOrder extends StatelessWidget {
  const AddOrder({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<CustomerProvider>(
      builder: (context, customerProvider, child) => Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0, left: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: Constants.BORDER_RADIUS_15,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //title
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [DefaultText(txt: "Products")],
                              ),
                            ),
                            const SizedBox(height: 20),

                            //search fo product
                            DefaultForm(
                              title: 'Search For Products',
                              controller: Provider.of<ProductVM>(context, listen: false).searchController,
                              numberOfLines: 1,
                            ),
                            const SizedBox(height: 20),

                            //list of products
                            const ProductToAdd(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: Constants.BORDER_RADIUS_15,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [DefaultText(txt: "Customers")],
                            ),
                          ),
                          const SizedBox(height: 20),

                          //search for customer
                          DefaultForm(
                            title: 'Search For Customer',
                            controller: Provider.of<CustomerVM>(context, listen: false).searchController,
                            numberOfLines: 1,
                          ),
                          const SizedBox(height: 20),

                          //list of customers
                          const CustomerToAdd(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DefaultButton(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetailsStep()));
              }, title: "Continue", margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
            )
          ],
        ),
      ),
    );
  }
}




