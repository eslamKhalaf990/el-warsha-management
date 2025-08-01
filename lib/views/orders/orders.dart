import 'package:flutter/material.dart';
import 'package:warsha_app/views/orders/crud_order.dart';
import 'order_list.dart';

class Customers extends StatelessWidget {
  const Customers({super.key});

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
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: CRUDOrder(),
            ),
            OrderList()
          ],
        ),
      ),
    );
  }
}

