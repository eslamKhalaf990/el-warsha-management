
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          DefaultText(txt: "${orderItem.unitPrice} EGP", center: true),
        ],
      ),
    );
  }
}