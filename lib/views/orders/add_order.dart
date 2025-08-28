import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/add_customer.dart';
import 'package:warsha_app/controllers/payment_details.dart';
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
import 'package:warsha_app/views/products/add_product.dart';

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
                            child: Row(
                              children: [
                                Expanded(
                                  child: DefaultButton(
                                    onTap: () async {
                                      final orderVM = Provider.of<OrderVM>(
                                          context,
                                          listen: false);
                                      final payment =
                                          Provider.of<PaymentDetails>(context,
                                              listen: false);
                                      if (orderVM.orderModel.customer != null) {
                                        await orderVM.addOrder(
                                          customerID: orderVM
                                              .orderModel.customer!.customerID,
                                          orderItems:
                                              orderVM.orderModel.orderItems,
                                          delivery: payment.delivery.text,
                                          downPayment: payment.downPayment.text,
                                          discount: payment.discount.text,
                                          paymentMethod:
                                              payment.paymentMethod.text,
                                          orderSource:
                                              payment.platformSource.text,
                                        );
                                        Navigator.pop(context);
                                        orderVM.initAllOrders();
                                      }
                                    },
                                    isValid: !Provider.of<OrderVM>(context)
                                        .isLoading,
                                    isLoading:
                                        Provider.of<OrderVM>(context).isLoading,
                                    title: "Place Order",
                                    margin: EdgeInsets.zero,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 30),
                                  decoration: BoxDecoration(
                                      borderRadius: Constants.BORDER_RADIUS_15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const DefaultText(
                                        txt: "Total Price",
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      DefaultText(
                                        txt:
                                            "${(Provider.of<PaymentDetails>(context).totalPrice + Provider.of<OrderVM>(context).getTotalPrice())} EGP",
                                        color: Colors.white,
                                        bold: true,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
    return Consumer<PaymentDetails>(
      builder: (context, value, child) => CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [DefaultText(txt: "Order Details")],
              ),
            ),
          ),

          //customer info
          const SliverToBoxAdapter(child: CustomerOrderWidget()),

          const SliverToBoxAdapter(child: SizedBox(height: 15)),

          //delivery
          const SliverToBoxAdapter(child: DeliveryOrderWidget()),

          const SliverToBoxAdapter(child: SizedBox(height: 15)),

          //order item title
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
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

          //list of order items
          Provider.of<OrderVM>(context).orderModel.orderItems.isNotEmpty
              ? SliverFixedExtentList(
                  itemExtent: 60,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: OrderItemWidget(index),
                      );
                    },
                    childCount: Provider.of<OrderVM>(context)
                        .orderModel
                        .orderItems
                        .length,
                  ),
                )
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.shopping_cart,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const DefaultText(txt: "Put items in list first!"),
                      ],
                    ),
                  ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.call_incoming_copy,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const DefaultText(txt: "Order Platform Source"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: DefaultProductForm(
                    fillColor:
                        Theme.of(context).colorScheme.tertiary.withAlpha(30),
                    title: "Which platform you get the order from?",
                    controller: value.platformSource,
                    onChange: (value) {},
                    icon: Iconsax.facebook,
                  ),
                ),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 15)),

          //payment details
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.wallet_1_copy,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const DefaultText(txt: "Payment Details"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: DefaultProductForm(
                          currency: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withAlpha(30),
                          title: "Down Payment",
                          controller: value.downPayment,
                          onChange: (value) {},
                          icon: Iconsax.wallet_1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: DefaultProductForm(
                          currency: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withAlpha(30),
                          title: "Delivery Charge",
                          controller: value.delivery,
                          onChange: (value) {},
                          icon: Iconsax.truck,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20),
                      child: DefaultProductForm(
                        currency: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withAlpha(30),
                        title: "Discount",
                        controller: value.discount,
                        onChange: (value) {},
                        icon: Iconsax.discount_shape,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20),
                      child: DefaultProductForm(
                        fillColor: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withAlpha(30),
                        title: "Payment Method",
                        controller: value.paymentMethod,
                        onChange: (value) {},
                        icon: Iconsax.wallet_1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}
