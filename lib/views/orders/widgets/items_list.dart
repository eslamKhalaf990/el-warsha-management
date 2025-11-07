// import 'package:flutter/material.dart';
// import 'package:warsha_app/models/order_model.dart';
// import 'package:warsha_app/order_upgrading/models/orderModel.dart';
// import 'package:warsha_app/utils/const_values.dart';
// import 'package:warsha_app/utils/default_text.dart';
//
//
// class ItemsList extends StatelessWidget {
//   const ItemsList({super.key, required this.order});
//
//   final OrderModel order;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(
//         order.orderItems.length,
//             (index) => Container(
//             decoration: BoxDecoration(
//               borderRadius: Constants.BORDER_RADIUS_20,
//               color: Theme.of(context).colorScheme.tertiary.withAlpha(50),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
//             margin: const EdgeInsets.symmetric(vertical: 5),
//             child: DefaultText(
//                 txt:
//                 "${index + 1}. ${order.orderItems[index].productName} \t\t ${order.orderItems[index].quantity} Piece \t\t ${order.orderItems[index].unitPrice} EGP")),
//       ),
//     );
//   }
// }
