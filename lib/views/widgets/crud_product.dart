import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/deafualt_form_field.dart';

class CRUDProduct extends StatelessWidget {
  const CRUDProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: DefaultForm(
                title: 'Search For Product By Name or ID',
                controller: TextEditingController(),
                numberOfLines: 1,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                Theme.of(context).colorScheme.surfaceTint,
                borderRadius: Constants.BORDER_RADIUS_50,
              ),
              child: Icon(
                Iconsax.add,
                color:
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                Theme.of(context).colorScheme.surfaceTint,
                borderRadius: Constants.BORDER_RADIUS_50,
              ),
              child: Icon(
                Iconsax.edit,
                color:
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                Theme.of(context).colorScheme.surfaceTint,
                borderRadius: Constants.BORDER_RADIUS_50,
              ),
              child: Icon(
                Iconsax.close_square,
                color: Colors.red.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
