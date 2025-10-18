import 'package:flutter/material.dart';
import 'package:warsha_app/views/orders/search_add_order.dart';
import 'package:warsha_app/views/orders/widgets/build_cell.dart';
import 'governorate_count_list_order.dart';
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
            const GovernorateCountList(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                children: [
                  buildCell('#', flex: 2, isBold: true),
                  buildCell('Date', flex: 2, isBold: true),
                  buildCell('Source', flex: 2, isBold: true),
                  buildCell('Name', flex: 4, isBold: true),
                  buildCell('Phone', flex: 3, isBold: true),
                  buildCell('Status', flex: 4, isBold: true),
                  buildCell('Total price', flex: 2, isBold: true),
                  buildCell('Payment', flex: 4, isBold: true),
                  buildCell('Action', flex: 4, isBold: true),
                ],),
            ),
            const OrderList()
          ],
        ),
      ),
    );
  }
}

