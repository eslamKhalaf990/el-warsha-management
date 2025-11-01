// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:warsha_app/models/order_model.dart';
// import 'package:warsha_app/order_upgrading/models/orderModel.dart';
// import 'package:warsha_app/services/base_url.dart';
// import 'package:warsha_app/utils/const_values.dart';
// import 'package:warsha_app/utils/date.dart';
// import 'package:warsha_app/view_models/add_order_v_m.dart';
// import 'package:warsha_app/views/orders/update_order/update_order.dart';
// import 'package:warsha_app/views/orders/widgets/build_cell.dart';
// import 'package:warsha_app/views/orders/widgets/update_order_status.dart';
// import 'package:warsha_app/views/products/invoices.dart';
//
// class OrderExpandableRow extends StatefulWidget {
//   final OrderModel order;
//   final VoidCallback onView;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;
//
//   const OrderExpandableRow({
//     super.key,
//     required this.order,
//     required this.onView,
//     required this.onEdit,
//     required this.onDelete,
//   });
//
//   @override
//   State<OrderExpandableRow> createState() => _OrderExpandableRowState();
// }
//
// class _OrderExpandableRowState extends State<OrderExpandableRow> {
//   bool _expanded = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final order = widget.order;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40.0),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(color: Colors.grey.shade300, width: 1),
//               ),
//             ),
//             child: Row(
//               children: [
//                 buildCell('#${order.orderId}', flex: 2, isBold: true),
//                 buildCell(DateHelper.formatDate1(order.orderDate.toString()), flex: 2, isBold: true),
//                 buildCell(order.orderSource, flex: 2, isBold: true),
//                 buildCell(order.customer.fullName, flex: 4, isBold: true),
//                 buildCell(order.customer.phone,
//                     flex: 3, isBold: true),
//                 Expanded(
//                   flex: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 6.0),
//                     child: Chip(
//                       label: SizedBox(
//                         width: 120,
//                         height: 25,
//                         child: OrderStatusDropdown(
//                           currentStatus: order.status,
//                           order: order,
//                           onStatusChanged: (value) {},
//                         ),
//                       ),
//                       padding: EdgeInsets.zero,
//                       labelStyle: const TextStyle(fontSize: 12),
//                       backgroundColor: Theme.of(context).colorScheme.onPrimary,
//                       side: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 buildCell('${order.totalPrice} EGP',
//                     flex: 2, isBold: order.totalPrice > 0),
//                 buildCell(order.paymentMethod, flex: 4, isBold: true),
//                 Expanded(
//                   flex: 4,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Iconsax.eye_copy, size: 20),
//                         onPressed: () => setState(() => _expanded = !_expanded),
//                       ),
//                       IconButton(
//                         icon: const Icon(Iconsax.document_text_copy,
//                             size: 20, color: Colors.green),
//                         onPressed: (){
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PDFViewPage(
//                                   pdfPath: "${Baseurl.invoiceAPI}/${order.orderId}"),
//                             ),
//                           );
//                         },
//                       ),
//                       IconButton(
//                           icon: const Icon(Iconsax.edit_2_copy,
//                               size: 20, color: Colors.blue),
//                           onPressed: (){
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => UpdateOrder(
//                                   existingOrder: order,
//                                 ),
//                               ),
//                             );
//                           },
//                       ),
//                       IconButton(
//                         icon: !Provider.of<AddOrderVM>(context).isLoading ||
//                             (order.orderId) != Provider.of<AddOrderVM>(context).deletedOrder
//                             ? const Icon(Iconsax.trash_copy, size: 20, color: Colors.red)
//                             : const SpinKitChasingDots(color: Colors.red, size: 20),
//                         onPressed: !Provider.of<AddOrderVM>(context).isLoading
//                             ? () async {
//                           final confirm = await showDialog<bool>(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 title: const Text('Confirm Deletion'),
//                                 content: Text('Are you sure you want to delete order #${order.orderId}?'),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () => Navigator.pop(context, false),
//                                     child: const Text('Cancel'),
//                                   ),
//                                   ElevatedButton(
//                                     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                                     onPressed: () => Navigator.pop(context, true),
//                                     child: const Text('Delete'),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//
//                           if (confirm != true) return; // Cancel pressed
//
//                           final orderVM = Provider.of<AddOrderVM>(context, listen: false);
//                           final state = await orderVM.deleteOrderByID(order.orderId.toString());
//
//                           if (state == "deleted") {
//                             orderVM.initAllOrders();
//                             if (context.mounted) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text('Order #${order.orderId} deleted successfully.'),
//                                   backgroundColor: Colors.red,
//                                   duration: const Duration(seconds: 2),
//                                 ),
//                               );
//                             }
//                           }
//                         }
//                             : null,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Expanded order items (only visible when expanded)
//           _expanded
//               ? Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
//             child: Column(
//               children: [
//                 // Address and down payment
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                   child: const Row(
//                     children: [
//                       Expanded(
//                         flex: 4,
//                         child: Text("Address details",
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text("Delivery",
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text("Down payment",
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//
//
//                     ],
//                   ),
//                 ),
//
//                 // Address and down payment
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Theme.of(context).colorScheme.tertiary.withAlpha(50), width: 1),
//                       borderRadius: Constants.BORDER_RADIUS_20
//                   ),
//                   child: Row(
//                     children: [
//
//                     Expanded(
//                       flex: 4,
//                       child: Text("${order.customer!.address} - ${order.customer!.governorate}",
//                           style: const TextStyle()),
//                     ),
//                       Expanded(
//                         flex: 2,
//                         child: Text("${order.delivery} EGP",
//                             style: const TextStyle()),
//                       ),Expanded(
//                         flex: 2,
//                         child: Text("${order.downPayment} EGP",
//                             style: const TextStyle()),
//                       )
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Header for items
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Theme.of(context).colorScheme.tertiary.withAlpha(50), width: 1),
//                       borderRadius: Constants.BORDER_RADIUS_20
//                   ),
//                   child: const Row(
//                     children: [
//                       Expanded(
//                         flex: 4,
//                         child: Text('Product',
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text('Qty',
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text('Price',
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Text('Total',
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Order items
//                 Center(
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 5),
//                     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Theme.of(context).colorScheme.tertiary.withAlpha(50), width: 1),
//                         borderRadius: Constants.BORDER_RADIUS_20
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ...order.orderItems.map((item) {
//                           return Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 flex: 4,
//                                 child:
//                                 Text(item.productName, overflow: TextOverflow.ellipsis,style: const TextStyle(),),
//                               ),
//                               Expanded(flex: 2, child: Text(item.quantity.toString())),
//                               Expanded(flex: 2, child: Text("${item.unitPrice} EGP")),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   '${item.unitPrice * item.quantity} EGP',
//                                 ),
//                               ),
//                             ],
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                   child: const Row(
//                     children: [
//                       Text("Additional notes",
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//
//                 // notes
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Theme.of(context).colorScheme.tertiary.withAlpha(50), width: 1),
//                     borderRadius: Constants.BORDER_RADIUS_20
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 4,
//                         child: Text("${order.notes}",
//                             style: const TextStyle()),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )
//               : const SizedBox.shrink(),
//         ],
//       ),
//     );
//   }
// }
