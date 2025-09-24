import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/update_order_v_m.dart';

class OrderStatusDropdown extends StatefulWidget {
  final String currentStatus;
  final OrderModel order;
  final Function(String) onStatusChanged;

  const OrderStatusDropdown({
    super.key,
    required this.currentStatus,
    required this.onStatusChanged,
    required this.order,
  });

  @override
  State<OrderStatusDropdown> createState() => _OrderStatusDropdownState();
}
class _OrderStatusDropdownState extends State<OrderStatusDropdown> {
  late String selectedStatus;

  final List<String> statuses = [
    "Pending",
    "Completed",
    "Shipped",
  ];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.currentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow.shade300,
        borderRadius: Constants.BORDER_RADIUS_20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedStatus,
          isExpanded: true,
          icon: const Icon(
            Iconsax.arrow_down_2_copy,
            size: 20,
          ),
          dropdownColor: Colors.white,
          items: statuses.map((status) {
            return DropdownMenuItem(
              value: status,
              child: DefaultText(
                txt: status,
                size: 14,
                bold: true,
              ),
            );
          }).toList(),
          onChanged: (value) async {
            if (value != null) {
              setState(() {
                selectedStatus = value;
              });
              await Provider.of<UpdateOrderVM>(context, listen: false)
                  .updateOrderStatus(
                  orderID: widget.order.orderID, statusValue: value);
              widget.onStatusChanged(value);
            }
          },
        ),
      ),
    );
  }
}