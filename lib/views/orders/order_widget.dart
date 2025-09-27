import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/views/orders/widgets/items_list.dart';
import 'package:warsha_app/views/orders/widgets/order_crud.dart';
import 'package:warsha_app/views/orders/widgets/update_order_status.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;

  const OrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(100),
        borderRadius: Constants.BORDER_RADIUS_20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //profile picture
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceTint,
              borderRadius: Constants.BORDER_RADIUS_20,
            ),
            child: const Icon(
              Iconsax.profile_circle,
              size: 50,
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // order id, order date and status
                    Row(
                      children: [
                        DefaultText(
                          txt: "Order ID: ${order.orderID}",
                          bold: true,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(width: 10),
                        DefaultText(
                          txt: order.orderDate,
                          bold: true,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        //order status
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 120,
                          height: 25,
                          child: OrderStatusDropdown(
                            currentStatus: order.status,
                            order: order,
                            onStatusChanged: (value) {},
                          ),
                        ),
                      ],
                    ),

                    //total price, payment method,
                    Row(
                      children: [
                        //total price
                        DefaultText(
                          txt: "Total Price: ${order.totalPrice} EGP",
                          bold: true,
                        ),
                        const SizedBox(width: 10),

                        //separator
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(width: 10),

                        //payment
                        DefaultText(
                          txt: "Payment method: ${order.paymentMethod}",
                          bold: true,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),

                    const SizedBox(height: 6),
                    //delivery, down payment
                    Row(
                      children: [
                        //delivery
                        DefaultText(
                          txt: "Delivery: ${order.delivery} EGP",
                          bold: true,
                        ),
                        const SizedBox(width: 10),

                        //separator
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(width: 10),

                        //payment
                        DefaultText(
                          txt: "Down payment: ${order.downPayment} EGP",
                          bold: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // customer name, customer phone
                    Row(
                      children: [
                        //customer name
                        DefaultText(
                          txt: order.customer!.name,
                          bold: true,
                        ),
                        const SizedBox(width: 10),

                        //separator
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(width: 10),

                        //phone
                        DefaultText(
                          txt: order.customer!.phone,
                          bold: true,
                        ),

                        const SizedBox(width: 10),

                        //separator
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(width: 10),

                        //phone
                        DefaultText(
                          txt: order.customer!.governorate,
                          bold: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // address
                    SizedBox(width: 500, child: Text(order.customer!.address)),
                    const SizedBox(height: 6),

                    //items list header
                    const Row(
                      children: [
                        Icon(
                          Iconsax.receipt_item_copy,
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Items List"),
                      ],
                    ),

                    ItemsList(order: order),
                    const SizedBox(height: 6),

                    const SizedBox(height: 5),
                    Divider(
                      color:
                          Theme.of(context).colorScheme.onSurface.withAlpha(50),
                      thickness: 0.5,
                    )
                  ],
                ),
              ],
            ),
          ),
          OrderCRUD(order: order),
        ],
      ),
    );
  }
}


