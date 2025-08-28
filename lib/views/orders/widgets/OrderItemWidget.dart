import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/order_v_m.dart';

class OrderItemWidget extends StatelessWidget {
  final int index;
  const OrderItemWidget(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final orderItem =
        Provider.of<OrderVM>(context).orderModel.orderItems[index];

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
          DefaultText(txt: orderItem.productName, center: true),
          
          Row(
            children: [
              InkWell(
                  onTap: (){
                    Provider.of<OrderVM>(context,listen: false).incrementItemQuantity = index;
                  },
                  child: const Icon(Iconsax.add_square_copy)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DefaultText(txt: orderItem.quantityToOrder.toString()),
              ),
              InkWell(
                  onTap: (){
                    Provider.of<OrderVM>(context,listen: false).decrementItemQuantity = index;
                  },
                  child: const Icon(Iconsax.minus_square_copy)),
              const SizedBox(width: 15,),
              DefaultText(txt: "${double.parse(orderItem.unitPrice) * orderItem.quantityToOrder} EGP", center: true),
            ],
          ),

        ],
      ),
    );
  }
}