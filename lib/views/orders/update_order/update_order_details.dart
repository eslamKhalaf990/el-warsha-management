import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/update_order/updatePaymentDetails.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/update_order_v_m.dart';
import 'package:warsha_app/views/products/add_product.dart';
import 'customer_details.dart';
import 'delivery_address.dart';
import 'order_item_widget.dart';

class UpdateOrderDetails extends StatelessWidget {
  const UpdateOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UpdatePaymentDetails, UpdateOrderVM>(
      builder: (context, payment, order, child) => CustomScrollView(
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
          const SliverToBoxAdapter(child: CustomerDetails()),

          const SliverToBoxAdapter(child: SizedBox(height: 15)),

          //delivery
          const SliverToBoxAdapter(child: DeliveryAddress()),

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

          // list of order items
          order.orderModel.orderItems.isNotEmpty
              ? SliverFixedExtentList(
                  itemExtent: 60,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: UpdateOrderItem(index, orderItem: Provider.of<UpdateOrderVM>(context).
                          orderModel.orderItems[index]),
                      );
                    },
                    childCount: order.orderModel.orderItems.length,
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
                  child: DropdownButtonFormField<String>(
                    borderRadius: Constants.BORDER_RADIUS_20,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.tertiary.withAlpha(30),
                      labelText: "Which platform did you get the order from?",
                      labelStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: Constants.BORDER_RADIUS_15),
                      prefixIcon: Icon(
                        Iconsax.message,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    value: payment.platformSource.text.isNotEmpty
                        ? payment.platformSource.text.toLowerCase()
                        : null, // bind to controller if already set
                    items: const [
                      DropdownMenuItem(
                          value: "facebook", child: Text("Facebook")),
                      DropdownMenuItem(value: "tiktok", child: Text("TikTok")),
                      DropdownMenuItem(
                          value: "instagram", child: Text("Instagram")),
                      DropdownMenuItem(
                          value: "ecommerce", child: Text("E-commerce")),
                      DropdownMenuItem(
                          value: "e-commerce", child: Text("E-commerce")),
                    ],
                    onChanged: (selected) {
                      if (selected != null) {
                        payment.platformSource.text = selected;
                      }
                    },
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
                          controller: payment.downPayment,
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
                          controller: payment.delivery,
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
                        controller: payment.discount,
                        onChange: (value) {},
                        icon: Iconsax.discount_shape,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withAlpha(30),
                          labelText: "Payment Method",
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: Constants.BORDER_RADIUS_15),
                          prefixIcon: Icon(Iconsax.wallet_1,
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        initialValue: payment.paymentMethod.text.isNotEmpty
                            ? payment.paymentMethod.text.toLowerCase()
                            : null,
                        items: const [
                          DropdownMenuItem(
                              value: "vodafone cash",
                              child: Text("Vodafone Cash")),
                          DropdownMenuItem(
                              value: "instapay", child: Text("Instapay")),
                          DropdownMenuItem(value: "cash", child: Text("Cash")),
                          DropdownMenuItem(value: "-", child: Text("Other")),
                        ],
                        onChanged: (selected) {
                          if (selected != null) {
                            payment.paymentMethod.text =
                                selected; // sync with controller
                          }
                        },
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
                        title: "Additional notes",
                        controller: payment.notes,
                        onChange: (value) {},
                        icon: Iconsax.note,
                        maxLines: 3,
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
