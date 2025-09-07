import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/services/base_url.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';
import 'package:warsha_app/views/orders/update_order/update_order.dart';
import 'package:warsha_app/views/products/invoices.dart';

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

                    Row(
                      children: [
                        DefaultText(
                          txt: "Delivery: ${order.delivery}",
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
                          txt: "Payment method: ${order.paymentMethod}",
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
                          txt: "Down payment: ${order.downPayment}",
                          bold: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Title
                    Row(
                      children: [
                        DefaultText(
                          txt: order.customer!.name,
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
                    SizedBox(width: 500, child: Text(order.customer!.address)),
                    const SizedBox(height: 6),

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
                                    "${index + 1}. ${order.orderItems[index].name} \t\t ${order.orderItems[index].quantity} Piece \t\t ${order.orderItems[index].unitPrice} EGP")),
                      ),
                    ),
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

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateOrder(existingOrder: order,),
                        ),
                      );
                    },
                    icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          borderRadius: Constants.BORDER_RADIUS_50,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.edit,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 5,),
                            DefaultText(txt: "Update Order", color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        )
                    ),
                  ),
                  IconButton(
                    onPressed: !Provider.of<AddOrderVM>(context).isLoading ? () async {
                      final orderVM = Provider.of<AddOrderVM>(context, listen: false);
                      final state = await orderVM.deleteOrderByID(order.orderID);
                      if (state == "deleted"){
                        orderVM.initAllOrders();
                      }
                    }: null,
                    icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          borderRadius: Constants.BORDER_RADIUS_50,
                        ),
                        child: !Provider.of<AddOrderVM>(context).isLoading || (order.orderID) != Provider.of<AddOrderVM>(context).deletedOrder ? Row(
                          children: [
                            Icon(
                              Iconsax.trash,
                              color: Colors.red.shade300,
                            ),
                            const SizedBox(width: 5,),
                             DefaultText(txt: "Delete Order", color: Colors.red.shade300,
                            ),
                          ],
                        ) : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 33.0),
                          child: SpinKitThreeBounce(color: Colors.red.shade300, size: 20),
                        )
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFViewPage(
                          pdfPath: "${Baseurl.invoiceAPI}/${order.orderID}"),
                    ),
                  );
                },
                icon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceTint,
                      borderRadius: Constants.BORDER_RADIUS_50,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.document_text,
                           color: Colors.green.shade600,
                        ),
                        const SizedBox(width: 5,),
                        DefaultText(txt: "View Order Invoice", color: Colors.green.shade600,),
                      ],
                    )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
