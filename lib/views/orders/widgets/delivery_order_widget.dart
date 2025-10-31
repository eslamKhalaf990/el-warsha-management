import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';

class DeliveryOrderWidget extends StatelessWidget {
  const DeliveryOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
            child: Row(
              children: [
                Icon(
                  Iconsax.location_copy,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 22,
                ),
                const SizedBox(
                  width: 5,
                ),
                const DefaultText(
                  txt: "Deliver To",
                  size: 13,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary.withAlpha(20),
              borderRadius: Constants.BORDER_RADIUS_15,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child:  Row(
              children: [
                // Text(
                //   Provider.of<AddOrderVM>(context).orderModel.customer?.address ??
                //   "Pick your customer!",
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}