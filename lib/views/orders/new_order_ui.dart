import 'package:flutter/material.dart';
import 'package:warsha_app/views/orders/search_add_order.dart';
import 'governorate_count_list_order.dart';
import 'order_list.dart';

class NewOrderUi extends StatelessWidget {
  const NewOrderUi({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the new UI state manager
    return Expanded(
      flex: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: CRUDOrder(),
            ),

            GovernorateCountList(),

            SizedBox(height: 8),

            Expanded(
              child: OrderList(),
            ),
          ],
        ),
      ),
    );
  }
}