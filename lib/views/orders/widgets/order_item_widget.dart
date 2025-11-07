import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

import 'package:warsha_app/models/orderItemModel.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';

class OrderItemWidget extends StatelessWidget {
  final int index;
  final OrderItemModel orderItem;
  const OrderItemWidget(this.index, {super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    final order = orderItem;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary.withAlpha(20),
        borderRadius: Constants.BORDER_RADIUS_15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(txt: order.productName, center: true),
          
          Row(
            children: [
              InkWell(
                  onTap: (){
                    Provider.of<AddOrderVM>(context,listen: false).incrementItemQuantity = index;
                  },
                  child: const Icon(Iconsax.add_square_copy)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DefaultText(txt: order.quantityToOrder.toString()),
              ),
              InkWell(
                  onTap: (){
                    Provider.of<AddOrderVM>(context,listen: false).decrementItemQuantity = index;
                  },
                  child: const Icon(Iconsax.minus_square_copy)),
              const SizedBox(width: 15,),
              DefaultText(txt: "${order.unitPrice * order.quantityToOrder} EGP", center: true),
            ],
          ),

        ],
      ),
    );
  }
}