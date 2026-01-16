import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/export_orders.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/deafualt_form_field.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';
import 'package:warsha_app/view_models/order_v_m.dart';
import 'package:warsha_app/views/orders/add_order/add_order.dart';
import 'package:warsha_app/views/orders/add_order/add_order_beta.dart';
import 'package:warsha_app/views/orders/add_order/claude_add_order.dart';

import 'add_order/gemini_add_order.dart';
import 'add_order/simple_add_order_gemini.dart';

class CRUDOrder extends StatelessWidget {
  const CRUDOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(100),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: DefaultForm(
                title: 'Search By Order Id or customer name or phone',
                controller: Provider.of<AddOrderVM>(context).searchController,
                onChanged: (v){},
                numberOfLines: 1,
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddOrderBeta(),
                  ),
                );
              },
              icon: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceTint,
                  borderRadius: Constants.BORDER_RADIUS_50,
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.receipt_item,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const DefaultText(txt: "Add Order (beta)", bold: true,),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddOrder(),
                  ),
                );
              },
              icon: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceTint,
                  borderRadius: Constants.BORDER_RADIUS_50,
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.receipt_item,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const DefaultText(txt: "Add Order", bold: true,),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                exportToExcel(Provider.of<OrderVM>(context, listen: false).orders);
              },
              icon: const Row(
                children: [
                  Icon(Iconsax.document_download_copy, color: Colors.green),
                  SizedBox(width: 5),
                  DefaultText(txt: "Export", bold: true,),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
