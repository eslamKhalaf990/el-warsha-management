import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/orderModel.dart';
import '../provider/orderProvider.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the provider for state changes
    final provider = context.watch<GetDeleteOrderVM>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders (Simple)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: provider.state == ViewState.loading
                ? null
                : () => context.read<GetDeleteOrderVM>().fetchOrders(),
          ),
        ],
      ),
      body: _buildBody(context, provider),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('TODO: Open Add Order Screen')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
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
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Phone')),
        DataColumn(label: Text('Governorate')),
        DataColumn(label: Text('Governorate')),
        DataColumn(label: Text('Governorate')),
        DataColumn(label: Text('Governorate')),
        DataColumn(label: Text('Order Date')),
        DataColumn(label: Text('Total')),
        DataColumn(label: Text('Source')),
        DataColumn(label: Text('Actions')),
      ],
      rows: orders
          .map((order) => _buildDataRow(context, order))
          .toList(),
    );
  }

  // This is the native Flutter DataRow
  DataRow _buildDataRow(BuildContext context, OrderModel order) {
    return DataRow(
      cells: [
        DataCell(Text('#${order.orderId}')),
        DataCell(Text(order.customer.fullName)),
        DataCell(Text(order.status)),
        DataCell(Text(order.customer.phone)),
        DataCell(Text(order.customer.governorate)),
        DataCell(Text(order.customer.governorate)),
        DataCell(Text(order.customer.governorate)),
        DataCell(Text(order.customer.governorate)),
        DataCell(Text(order.orderDate.toString())),
        DataCell(Text('${order.totalPrice.toStringAsFixed(2)} EGP')),
        DataCell(Text(order.orderSource.isEmpty ? 'N/A' : order.orderSource)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('TODO: Edit Order ${order.orderId}')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _showDeleteDialog(context, order.orderId),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, int orderId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete Order #$orderId?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              // Use context.read() inside callbacks
              context.read<GetDeleteOrderVM>().deleteOrder(orderId);
              Navigator.of(ctx).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}