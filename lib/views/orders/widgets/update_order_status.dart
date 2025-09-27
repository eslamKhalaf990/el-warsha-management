import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';
import 'package:warsha_app/view_models/update_order_v_m.dart';

class OrderStatusDropdown extends StatelessWidget {
  final String currentStatus;
  final OrderModel order;
  final Function(String) onStatusChanged;

  const OrderStatusDropdown({
    super.key,
    required this.currentStatus,
    required this.onStatusChanged,
    required this.order,
  });

  final List<String> statuses = const [
    "Pending",
    "Completed",
    "Shipped",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: currentStatus == "Pending"
            ? Colors.yellow.shade800
            : currentStatus == "Completed"
            ? Colors.green.shade300
            : Colors.brown.shade300,
        borderRadius: Constants.BORDER_RADIUS_20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentStatus,
          isExpanded: true,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          icon: const Icon(
            Iconsax.arrow_down_2_copy,
            size: 20,
            color: Colors.white,
          ),
          dropdownColor: Colors.white,
          items: statuses.map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(
                status,
                style: TextStyle(
                  color: status == currentStatus
                      ? Colors.white
                      : Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) async {
            if (value != null) {
              // update in backend/provider
              await Provider.of<UpdateOrderVM>(context, listen: false)
                  .updateOrderStatus(
                orderID: order.orderID,
                statusValue: value,
              );

              // notify parent
              onStatusChanged(value);

              // refresh orders list
              Provider.of<AddOrderVM>(context, listen: false).initAllOrders();
            }
          },
        ),
      ),
    );
  }
}
