import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/add_customer.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/deafualt_form_field.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/order_v_m.dart';
import 'package:warsha_app/views/orders/customer_to_add.dart';
import 'package:warsha_app/views/orders/product_to_add.dart';
import 'package:warsha_app/views/orders/widgets/CustomerOrderWidget.dart';
import 'package:warsha_app/views/orders/widgets/DeliveryOrderWidget.dart';
import 'package:warsha_app/views/orders/widgets/OrderItemWidget.dart';

class AddOrder extends StatelessWidget {
  const AddOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const DefaultText(txt: "Add New Order")),
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
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 15, left: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: Constants.BORDER_RADIUS_15,
                    ),
                    child: Stack(
                      children: [
                        const OrderDetailsWidget(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: DefaultButton(
                              onTap: () async {
                                final orderVM = Provider.of<OrderVM>(context, listen: false);
                                if(orderVM.orderModel.customer != null){
                                  await orderVM.addProduct(
                                    customerID: orderVM.orderModel.customer!.customerID,
                                    orderItems: orderVM.orderModel.orderItems,
                                  );
                                  Navigator.pop(context);
                                  orderVM.initAllOrders();
                                }
                              },
                              isValid: !Provider.of<OrderVM>(context).isLoading,
                              isLoading: Provider.of<OrderVM>(context).isLoading,
                              title: "Place Order",
                              margin: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 15, right: 7, left: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: Constants.BORDER_RADIUS_15,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [DefaultText(txt: "Products")],
                            ),
                          ),
                          const SizedBox(height: 20),
                          DefaultForm(
                            title: 'Search For Products',
                            controller: TextEditingController(),
                            numberOfLines: 1,
                          ),
                          const SizedBox(height: 20),
                          const ProductToAdd(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 15, right: 15, left: 7),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: Constants.BORDER_RADIUS_15,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [DefaultText(txt: "Customers")],
                            ),
                          ),
                          const SizedBox(height: 20),
                          DefaultForm(
                            title: 'Search For Customer',
                            controller: TextEditingController(),
                            numberOfLines: 1,
                          ),
                          const SizedBox(height: 20),
                          const CustomerToAdd(),
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

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [DefaultText(txt: "Order Details")],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: CustomerOrderWidget()),

        const SliverToBoxAdapter(child: SizedBox(height: 15)),

        const SliverToBoxAdapter(child: DeliveryOrderWidget()),

        const SliverToBoxAdapter(child: SizedBox(height: 15)),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
            child: Row(
              children: [
                Icon(
                  Iconsax.receipt_item_copy,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(
                  width: 5,
                ),
                const DefaultText(txt: "Order Items"),
              ],
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 60,
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: OrderItemWidget(index),
              );
            },
            childCount:
                Provider.of<OrderVM>(context).orderModel.orderItems.length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }
}





