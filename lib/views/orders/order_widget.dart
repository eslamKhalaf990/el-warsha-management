import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/services/base_url.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/views/products/invoices.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;

  const OrderWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(100),
        borderRadius: Constants.BORDER_RADIUS_20,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceTint,
                    borderRadius: Constants.BORDER_RADIUS_20,
                  ),
                  child: const Icon(
                    Iconsax.profile_circle,
                    size: 50,
                  )),
              const SizedBox(
                width: 20,
              ),
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
                            const SizedBox(width: 10),

                            DefaultText(
                              txt: "Total Price: ${order.totalPrice}",
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

                            const SizedBox(width: 10),

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade300,
                                  borderRadius: Constants.BORDER_RADIUS_20),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 0,
                              ),
                              child: DefaultText(
                                txt: order.status,
                                bold: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Title
                        Row(
                          children: [
                            DefaultText(
                              txt: order.customer!.customerName,
                              bold: true,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
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
                              txt: order.customer!.phone,
                              bold: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Message
                        Text(order.customer!.address),

                        const SizedBox(height: 6),
                        Row(
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

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            order.orderItems.length,
                            (index) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: Constants.BORDER_RADIUS_20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiary
                                      .withAlpha(50),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 4),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: DefaultText(
                                    txt:
                                        "${index + 1}. ${order.orderItems[index].productName} \t\t ${order.orderItems[index].quantity} Piece \t\t ${order.orderItems[index].unitPrice} EGP")),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const SizedBox(height: 5),
                        Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(50),
                          thickness: 0.5,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.green.shade300,
                                  borderRadius: Constants.BORDER_RADIUS_20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 2),
                              child: const Row(
                                children: [
                                  DefaultText(
                                      txt: "View Order Details",
                                      size: 14,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFViewPage(
                                    pdfPath:
                                        "${Baseurl.invoiceAPI}/${order.orderID}"),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red.shade300,
                                    borderRadius: Constants.BORDER_RADIUS_20),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 2),
                                child: const Row(
                                  children: [
                                    DefaultText(
                                        txt: "View Order Invoice",
                                        size: 14,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
