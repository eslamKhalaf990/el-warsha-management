import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';

import 'order_widget.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AddOrderVM>(context);

    return FutureBuilder<List<OrderModel>>(
      future: Provider.of<AddOrderVM>(context).allOrders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return OrderWidget(
                  order: snapshot.data![index],
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text("You haven't placed any orders yet!"),
          );
        }
      },
    );
  }
}
