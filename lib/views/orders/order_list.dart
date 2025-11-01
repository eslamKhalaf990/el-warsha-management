import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/order_upgrading/models/orderModel.dart';
import 'package:warsha_app/models/order_model.dart' as order_m;
import 'package:warsha_app/order_upgrading/provider/orderProvider.dart';
import 'package:warsha_app/services/base_url.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/date.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';
import 'package:warsha_app/views/orders/update_order/update_order.dart';
import 'package:warsha_app/views/products/invoices.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GetDeleteOrderVM>();

    return _buildBody(context, provider);
  }

  Widget _buildBody(BuildContext context, GetDeleteOrderVM provider) {
    switch (provider.state) {
      case ViewState.loading:
        return const Center(child: CircularProgressIndicator());
      case ViewState.error:
        return Center(
          child: Text(
            'Error: ${provider.errorMessage}',
            style: const TextStyle(color: Colors.red),
          ),
        );
      case ViewState.idle:
        if (provider.orders.isEmpty) {
          return const Center(child: Text('No orders found.'));
        }

        // The built-in DataTable must be wrapped in a SingleChildScrollView
        // and a SizedBox to allow horizontal scrolling on web.
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildDataTable(context, provider.orders),
            ),
          ),
        );
    }
  }

  // This is the native Flutter DataTable
  Widget _buildDataTable(BuildContext context, List<OrderModel> orders) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: DataTable(
        columns: const [
          DataColumn(label: DefaultText(txt: '#', bold: true)),
          DataColumn(label: DefaultText(txt: 'Order Date', bold: true)),
          DataColumn(label: DefaultText(txt: 'Customer', bold: true)),
          DataColumn(label: DefaultText(txt: 'Phone', bold: true)),
          DataColumn(label: DefaultText(txt: 'Status', bold: true)),
          DataColumn(label: DefaultText(txt: 'Governorate', bold: true)),
          DataColumn(label: DefaultText(txt: 'Total', bold: true)),
          DataColumn(label: DefaultText(txt: 'Source', bold: true)),
          DataColumn(label: DefaultText(txt: 'Actions', bold: true)),
        ],
        dividerThickness: 0.05,
        columnSpacing: 40,
        rows: orders.map((order) => _buildDataRow(context, order)).toList(),
      ),
    );
  }

  // This is the native Flutter DataRow
  DataRow _buildDataRow(BuildContext context, OrderModel order) {
    return DataRow(
      cells: [
        DataCell(Text('#${order.orderId}')),
        DataCell(Text(DateHelper.formatDatePicker(order.orderDate.toString()))),
        DataCell(Text(order.customer?.fullName ?? "-")),
        DataCell(Text(order.customer?.phone ??"-")),
        DataCell(Text(order.status?.toUpperCase() ?? "-")),
        DataCell(Text(order.customer?.governorate ?? "-")),
        DataCell(Text('${order.totalPrice?.toStringAsFixed(2) ?? "-"} EGP')),
        DataCell(Text(order.orderSource?.toUpperCase() ?? "-")),
        DataCell(_buildActionButtons(
            context, order, Provider.of<AddOrderVM>(context, listen: false))),
      ],
    );
  }

  Widget _buildActionButtons(
      BuildContext context, OrderModel order, AddOrderVM addOrderVM) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Iconsax.eye_copy, size: 20),
          onPressed: () => _showOrderDetails(context, order),
        ),
        IconButton(
          icon: const Icon(Iconsax.document_text_copy,
              size: 20, color: Colors.green),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewPage(
                    pdfPath: "${Baseurl.invoiceAPI}/${order.orderId}"),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Iconsax.edit_2_copy, size: 20, color: Colors.blue),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => UpdateOrder(
            //       existingOrder: order,
            //     ),
            //   ),
            // );
          },
        ),
        IconButton(
          icon: const Icon(Iconsax.trash_copy, size: 20, color: Colors.red),
          onPressed: !addOrderVM.isSaving
              ? () async => _deleteOrder(context, order, addOrderVM,
                  Provider.of<GetDeleteOrderVM>(context, listen: false))
              : null,
        ),
      ],
    );
  }

  Future<void> _deleteOrder(
    BuildContext context,
    OrderModel order,
    AddOrderVM orderVM,
    GetDeleteOrderVM provider,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content:
              Text('Are you sure you want to delete order #${order.orderId}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return; // Cancel pressed

    // final state = await orderVM.deleteOrderByID(order.orderId.toString());

    // if (state == "deleted") {
      provider.deleteOrder(
          order.orderId!); // This will trigger the FutureBuilder to refetch
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order #${order.orderId} deleted successfully.'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    // }
  }

  void _showOrderDetails(BuildContext context, OrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: ListView(
                controller: scrollController,
                children: [
                  Text('Order Details #${order.orderId}',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 20),

                  // All this UI is copied from your _expanded section
                  _buildDetailSection(
                    context,
                    "Delivery Details",
                    [
                      _buildDetailRow("Address:",
                          "${order.customer?.address ?? "-"} - ${order.customer?.governorate ?? "-"}"),
                      _buildDetailRow("Delivery:", "${order.delivery} EGP"),
                      _buildDetailRow(
                          "Down payment:", "${order.downPayment} EGP"),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _buildDetailSection(
                    context,
                    "Order Items",
                    [
                      // Items Header
                      const Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Text('Product',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 2,
                              child: Text('Qty',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 2,
                              child: Text('Price',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 2,
                              child: Text('Total',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withAlpha(50),
                      ),
                      // Items List
                      ...order.orderItems.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(flex: 4, child: Text(item.productName)),
                              Expanded(
                                  flex: 2,
                                  child: Text(item.quantity.toString())),
                              Expanded(
                                  flex: 2,
                                  child: Text("${item.unitPrice} EGP")),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${item.unitPrice * item.quantity} EGP',
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDetailSection(
                    context,
                    "Additional Notes",
                    [
                      Text(order.notes ?? "-"),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Helper widget for the modal
  Widget _buildDetailSection(
      BuildContext context, String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.tertiary.withAlpha(50),
              width: 1),
          borderRadius: Constants.BORDER_RADIUS_20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Divider(
            color: Theme.of(context).colorScheme.tertiary.withAlpha(50),
          ),
          ...children,
        ],
      ),
    );
  }

  // Helper widget for the modal
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
