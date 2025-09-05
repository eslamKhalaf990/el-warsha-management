import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/deafualt_form_field.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/views/orders/add_order/add_order.dart';

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
                title: 'Search By Order ID',
                controller: TextEditingController(),
                numberOfLines: 1,
              ),
            ),
            const SizedBox(width: 10),
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceTint,
                  borderRadius: Constants.BORDER_RADIUS_50,
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.add,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 5,),
                    const DefaultText(txt: "Add Order"),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
                padding: const EdgeInsets.all(10),
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
                    const DefaultText(txt: "Update Order"),
                  ],
                )
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceTint,
                borderRadius: Constants.BORDER_RADIUS_50,
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.close_square,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(width: 5,),
                  const DefaultText(txt: "Delete Order"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
