import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/deafualt_form_field.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/views/customers/add_customer.dart';

class CRUDCustomer extends StatelessWidget {
  const CRUDCustomer({super.key});

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
                title: 'Search For Customer By Name or ID',
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
                    builder: (context) => AddCustomer(),
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
                    const DefaultText(txt: "Add Customer"),
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
                    const DefaultText(txt: "Update Customer"),
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
                  const DefaultText(txt: "Delete Customer"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
