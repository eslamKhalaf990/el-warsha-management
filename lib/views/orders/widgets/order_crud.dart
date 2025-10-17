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


class OrderCRUD extends StatelessWidget {
  const OrderCRUD({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateOrder(
                          existingOrder: order,
                        ),
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
                          const SizedBox(
                            width: 5,
                          ),
                          DefaultText(
                            txt: "Update Order",
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      )),
                ),
                IconButton(
                  onPressed: !Provider.of<AddOrderVM>(context).isLoading
                      ? () async {
                    final orderVM =
                    Provider.of<AddOrderVM>(context, listen: false);
                    final state =
                    await orderVM.deleteOrderByID(order.orderID);
                    if (state == "deleted") {
                      orderVM.initAllOrders();
                    }
                  }
                      : null,
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceTint,
                      borderRadius: Constants.BORDER_RADIUS_50,
                    ),
                    child: !Provider.of<AddOrderVM>(context).isLoading ||
                        (order.orderID) !=
                            Provider.of<AddOrderVM>(context).deletedOrder
                        ? Row(
                      children: [
                        Icon(
                          Iconsax.trash,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        DefaultText(
                          txt: "Delete Order",
                          color: Colors.red.shade300,
                        ),
                      ],
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 33.0),
                      child: SpinKitThreeBounce(
                          color: Colors.red.shade300, size: 20),
                    ),
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
                      const SizedBox(
                        width: 5,
                      ),
                      DefaultText(
                        txt: "View Order Invoice",
                        color: Colors.green.shade600,
                      ),
                    ],
                  )),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: DefaultText(txt: order.notes, color: Theme.of(context).colorScheme.tertiary, bold: true,),
        ),
      ],
    );
  }
}
