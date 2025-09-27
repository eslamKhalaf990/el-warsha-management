import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/filter_orders.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/views/orders/search_add_order.dart';
import 'order_list.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .colorScheme
              .onPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: CRUDOrder(),
            ),
            Provider.of<GovernorateProvider>(context).selectedGovernorate != null ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary.withAlpha(50),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: DefaultText(txt: "Applied Filter: ${Provider.of<GovernorateProvider>(context).selectedGovernorate} has orders"),
                  ),
                )
              ],
            ):Container(),
            const OrderList()
          ],
        ),
      ),
    );
  }
}

