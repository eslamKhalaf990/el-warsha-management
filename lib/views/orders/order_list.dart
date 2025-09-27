import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/filter_orders.dart';
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
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: SpinKitChasingDots(color: Theme.of(context).colorScheme.secondary, size: 30,),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isNotEmpty) {
          final filteredOrders = snapshot.data!.where((order) {
            final governorate = order.customer!.governorate.toLowerCase();
            final status = order.status.toLowerCase() ?? "";
            final query = Provider.of<GovernorateProvider>(context).selectedGovernorate;
            return governorate.contains(query ?? "") || status.contains(query ?? "");
          }).toList();
          return Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return OrderWidget(
                  order: filteredOrders[index],
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
