import 'package:flutter/material.dart';
import 'package:warsha_app/views/orders/search_add_order.dart';
import 'governorate_count_list_order.dart';
import 'order_table.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}