// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:warsha_app/controllers/filter_orders.dart';
// import 'package:warsha_app/controllers/new_order_provider.dart';
// import 'package:warsha_app/models/order_model.dart';
// import 'package:warsha_app/order_upgrading/models/orderModel.dart';
// import 'package:warsha_app/services/base_url.dart';
// import 'package:warsha_app/utils/const_values.dart';
// import 'package:warsha_app/utils/date.dart';
// import 'package:warsha_app/view_models/add_order_v_m.dart';
// import 'package:warsha_app/views/orders/update_order/update_order.dart';
// import 'package:warsha_app/views/orders/widgets/update_order_status.dart';
// import 'package:warsha_app/views/products/invoices.dart';
//
// class OrdersDataTable extends StatelessWidget {
//   const OrdersDataTable({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Get all providers
//     final tableProvider = context.watch<OrdersTableProvider>();
//     final query = context.watch<GovernorateProvider>().selectedGovernorate;
//     final query2 = context.watch<AddOrderVM>().searchController.text;
//     final addOrderVM = context.watch<AddOrderVM>(); // For delete action
//     final ScrollController verticalController = ScrollController();
//     final ScrollController horizontalController = ScrollController();
//
//     // Sync the filter query to the table provider
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       tableProvider.setFilter(query);
//     });
//
//     // Sync the filter query to the table provider
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       tableProvider.setSearch(query2);
//     });
//
//     return FutureBuilder<List<OrderModel>>(
//       // We use listen: false in the future, as the VM is just a data source.
//       // The tableProvider (which we watch) will handle rebuilds.
//       future: Provider.of<AddOrderVM>(context, listen: false).allOrders,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 100.0),
//               child: SpinKitChasingDots(
//                 color: Theme.of(context).colorScheme.secondary,
//                 size: 30,
//               ),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (snapshot.data != null && snapshot.data!.isNotEmpty) {
//           final masterList = snapshot.data!;
//
//           // Sync the master list to the table provider
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             tableProvider.setOrders(masterList);
//           });
//
//           // The old filter logic is now gone. tableProvider handles it.
//
//           return ClipRRect(
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//             child: Scrollbar(
//               thumbVisibility: true,
//               controller: verticalController,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 controller: verticalController,
//                 child: SingleChildScrollView(
//                   controller: horizontalController,
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     sortColumnIndex: tableProvider.sortColumnIndex,
//                     sortAscending: tableProvider.sortAscending,
//
//                     border: TableBorder.all(color: Theme.of(context).colorScheme.onPrimary),
//                     dividerThickness: 0,
//                     columnSpacing: 70,
//                     headingRowColor: WidgetStatePropertyAll(
//                       Theme.of(context).colorScheme.primary.withAlpha(40),
//                     ),
//                     dataRowMinHeight: 52,
//                     dataRowMaxHeight: 52,
//                     columns: [
//                       _buildSortableColumn(
//                         '#', 0, tableProvider,
//                             (o) => o.orderID, // Assuming orderID is a number or comparable string
//                       ),
//                       _buildSortableColumn(
//                         'Date', 1, tableProvider, (o) => o.orderDate,
//                       ),
//                       _buildSortableColumn(
//                         'Source', 2, tableProvider, (o) => o.orderSource,
//                       ),
//                       _buildSortableColumn(
//                         'Name', 3, tableProvider, (o) => o.customer!.name,
//                       ),
//                       _buildSortableColumn(
//                         'Phone', 4, tableProvider, (o) => o.customer!.phone,
//                       ),
//                       _buildSortableColumn(
//                         'Status', 5, tableProvider, (o) => o.status,
//                       ),
//                       _buildSortableColumn(
//                         'Total price', 6, tableProvider,
//                             (o) => double.tryParse(o.totalPrice) ?? 0,
//                         numeric: true,
//                       ),
//                       _buildSortableColumn(
//                         'Payment', 7, tableProvider, (o) => o.paymentMethod,
//                       ),
//                       const DataColumn(label: Text('Action')),
//                     ],
//                     rows: tableProvider.displayOrders.map((order) {
//                       return DataRow(
//
//                         cells: [
//                           DataCell(Text('#${order.orderID}')),
//                           DataCell(Text(DateHelper.formatDate1(order.orderDate))),
//                           DataCell(Text(order.orderSource)),
//                           DataCell(Text(order.customer!.name)),
//                           DataCell(Text(order.customer!.phone)),
//                           DataCell(
//                             SizedBox(
//                               width: 120, // Give dropdown a fixed width
//                               height: 30,
//                               child: OrderStatusDropdown(
//                                 currentStatus: order.status,
//                                 order: order,
//                                 onStatusChanged: (value) {
//                                   order.status = value;
//                                   tableProvider.updateOrders();
//                                 }
//                               ),
//                             ),
//                           ),
//                           DataCell(Text('${order.totalPrice} EGP')),
//                           DataCell(Text(order.paymentMethod)),
//                           DataCell(_buildActionButtons(
//                             context,
//                             order,
//                             addOrderVM,
//                           )),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         } else {
//           return const Center(
//             child: Padding(
//               padding: EdgeInsets.all(50.0),
//               child: Text("You haven't placed any orders yet!"),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   /// Helper to create a sortable DataColumn.
//   DataColumn _buildSortableColumn(
//       String label,
//       int index,
//       OrdersTableProvider provider,
//       Comparable Function(OrderModel order) getField, {
//         bool numeric = false,
//       }) {
//     return DataColumn(
//       label: Text(label),
//       numeric: numeric,
//       onSort: (i, asc) => provider.sort(getField, i, asc),
//     );
//   }
//
//   /// Helper for the action buttons cell (from old OrderExpandableRow).
//   Widget _buildActionButtons(
//       BuildContext context,
//       OrderModel order,
//       AddOrderVM addOrderVM,
//       ) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//           icon: const Icon(Iconsax.eye_copy, size: 20),
//           onPressed: () => _showOrderDetails(context, order),
//         ),
//         IconButton(
//           icon: const Icon(Iconsax.document_text_copy,
//               size: 20, color: Colors.green),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PDFViewPage(
//                     pdfPath: "${Baseurl.invoiceAPI}/${order.orderID}"),
//               ),
//             );
//           },
//         ),
//         IconButton(
//           icon: const Icon(Iconsax.edit_2_copy, size: 20, color: Colors.blue),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => UpdateOrder(
//                   existingOrder: order,
//                 ),
//               ),
//             );
//           },
//         ),
//         IconButton(
//           icon: !addOrderVM.isLoading || (order.orderID) != addOrderVM.deletedOrder
//               ? const Icon(Iconsax.trash_copy, size: 20, color: Colors.red)
//               : const SpinKitChasingDots(color: Colors.red, size: 20),
//           onPressed: !addOrderVM.isLoading
//               ? () async => _deleteOrder(context, order, addOrderVM)
//               : null,
//         ),
//       ],
//     );
//   }
//
//   /// Helper to show the details in a modal bottom sheet.
//   void _showOrderDetails(BuildContext context, OrderModel order) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (_) {
//         return DraggableScrollableSheet(
//           expand: false,
//           initialChildSize: 0.6,
//           maxChildSize: 0.9,
//           minChildSize: 0.4,
//           builder: (context, scrollController) {
//             return Container(
//               padding: const EdgeInsets.all(24),
//               child: ListView(
//                 controller: scrollController,
//                 children: [
//                   Text('Order Details #${order.orderId}',
//                       style: Theme.of(context).textTheme.headlineSmall),
//                   const SizedBox(height: 20),
//
//                   // All this UI is copied from your _expanded section
//                   _buildDetailSection(
//                     context,
//                     "Delivery Details",
//                     [
//                       _buildDetailRow("Address:",
//                           "${order.customer!.address} - ${order.customer!.governorate}"),
//                       _buildDetailRow("Delivery:", "${order.delivery} EGP"),
//                       _buildDetailRow(
//                           "Down payment:", "${order.downPayment} EGP"),
//                     ],
//                   ),
//
//                   const SizedBox(height: 20),
//                   _buildDetailSection(
//                     context,
//                     "Order Items",
//                     [
//                       // Items Header
//                       const Row(
//                         children: [
//                           Expanded(
//                               flex: 4,
//                               child: Text('Product',
//                                   style:
//                                   TextStyle(fontWeight: FontWeight.bold))),
//                           Expanded(
//                               flex: 2,
//                               child: Text('Qty',
//                                   style:
//                                   TextStyle(fontWeight: FontWeight.bold))),
//                           Expanded(
//                               flex: 2,
//                               child: Text('Price',
//                                   style:
//                                   TextStyle(fontWeight: FontWeight.bold))),
//                           Expanded(
//                               flex: 2,
//                               child: Text('Total',
//                                   style:
//                                   TextStyle(fontWeight: FontWeight.bold))),
//                         ],
//                       ),
//                       Divider(color: Theme.of(context).colorScheme.tertiary.withAlpha(50),),
//                       // Items List
//                       ...order.orderItems.map((item) {
//                         return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 4.0),
//                             child: Row(
//                               children: [
//                                 Expanded(flex: 4, child: Text(item.name)),
//                                 Expanded(
//                                     flex: 2, child: Text(item.quantity.toString())),
//                                 Expanded(
//                                     flex: 2, child: Text("${item.unitPrice} EGP")),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     '${double.parse(item.unitPrice) * double.parse(item.quantity)} EGP',
//                                   ),
//                                 ),
//                               ],
//                             ));
//                         }),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   _buildDetailSection(
//                     context,
//                     "Additional Notes",
//                     [
//                       Text(order.notes),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   // Helper widget for the modal
//   Widget _buildDetailSection(
//       BuildContext context, String title, List<Widget> children) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//           border: Border.all(
//               color: Theme.of(context).colorScheme.tertiary.withAlpha(50),
//               width: 1),
//           borderRadius: Constants.BORDER_RADIUS_20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           Divider(color: Theme.of(context).colorScheme.tertiary.withAlpha(50),),
//           ...children,
//         ],
//       ),
//     );
//   }
//
//   // Helper widget for the modal
//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(width: 8),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
//
//   /// Delete logic (extracted from old widget).
//   Future<void> _deleteOrder(
//       BuildContext context,
//       OrderModel order,
//       AddOrderVM orderVM,
//       ) async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Confirm Deletion'),
//           content: Text('Are you sure you want to delete order #${order.orderId}?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, false),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//               onPressed: () => Navigator.pop(context, true),
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//
//     if (confirm != true) return; // Cancel pressed
//
//     final state = await orderVM.deleteOrderByID(order.orderId.toString());
//
//     if (state == "deleted") {
//       orderVM.initAllOrders(); // This will trigger the FutureBuilder to refetch
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Order #${order.orderId} deleted successfully.'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }
// }