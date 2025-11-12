import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/account_balance.dart';
import 'package:warsha_app/models/orderModel.dart';
import 'package:warsha_app/view_models/accountings_v_m.dart';
import 'package:warsha_app/view_models/order_v_m.dart';
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
    final provider = context.watch<OrderVM>();

    switch (provider.state) {
      case ViewState.loading:
        return Center(
          child: SpinKitChasingDots(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        );
      case ViewState.error:
        return Center(
          child: Text(
            'Error: ${provider.errorMessage}',
            style: const TextStyle(color: Colors.red),
          ),
        );
      case ViewState.idle:
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildDataTable(context, provider),
            ),
          ),
        );
    }
  }

  // This is the native Flutter DataTable
  Widget _buildDataTable(BuildContext context, OrderVM orderVM) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: DataTable(
        sortColumnIndex: orderVM.sortColumnIndex,
        sortAscending: orderVM.sortAscending,
        dividerThickness: 0.05,
        columnSpacing: 40,
        headingRowHeight: 70, // taller to fit filters under headers
        columns: [
          DataColumn(
            label: const DefaultText(txt: '#', bold: true),
            onSort: (columnIndex, ascending) {
              orderVM.sort<num>(
                  (order) => order.orderId ?? 0, columnIndex, ascending);
            },
          ),
          DataColumn(
            label: const DefaultText(txt: 'Order Date', bold: true),
            onSort: (columnIndex, ascending) {
              orderVM.sort<DateTime>(
                (order) => order.orderDate ?? DateTime.now(),
                columnIndex,
                ascending,
              );
            },
          ),

          // Customer
          DataColumn(
            label: SizedBox(
              height: 22,
              width: 120,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Customer',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  suffixIcon: Icon(Iconsax.sort_copy, size: 20),
                ),
                controller: orderVM.customer,
                onChanged: (val) => orderVM.applyFilter('customer', val),
              ),
            ),
            onSort: (columnIndex, ascending) {
              orderVM.sort<String>(
                (order) => order.customer?.fullName ?? '',
                columnIndex,
                ascending,
              );
            },
          ),

          // Phone
          DataColumn(
            label: SizedBox(
              height: 22,
              width: 120,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Phone',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  suffixIcon: Icon(Iconsax.sort_copy, size: 20),
                ),
                controller: orderVM.phone,
                onChanged: (val) => orderVM.applyFilter('phone', val),
              ),
            ),
            onSort: (columnIndex, ascending) {
              orderVM.sort<String>(
                (order) => order.customer?.phone ?? '',
                columnIndex,
                ascending,
              );
            },
          ),

          // Status
          DataColumn(
            label: SizedBox(
              height: 22,
              width: 120,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Status',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  suffixIcon: Icon(Iconsax.sort_copy, size: 20),
                ),
                controller: orderVM.status,
                onChanged: (val) => orderVM.applyFilter('status', val),
              ),
            ),
            onSort: (columnIndex, ascending) {
              orderVM.sort<String>(
                (order) => order.status ?? '',
                columnIndex,
                ascending,
              );
            },
          ),

          // Governorate
          DataColumn(
            label: SizedBox(
              height: 22,
              width: 120,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Governorate',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  suffixIcon: Icon(Iconsax.sort_copy, size: 20),
                ),
                controller: orderVM.governorate,
                onChanged: (val) => orderVM.applyFilter('governorate', val),
              ),
            ),
            onSort: (columnIndex, ascending) {
              orderVM.sort<String>(
                (order) => order.customer?.governorate ?? '',
                columnIndex,
                ascending,
              );
            },
          ),

          // Total
          DataColumn(
            label: SizedBox(
              height: 22,
              width: 120,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Total',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  suffixIcon: Icon(Iconsax.sort_copy, size: 20),
                ),
                controller: orderVM.total,
                onChanged: (val) => orderVM.applyFilter('total', val),
              ),
            ),
            onSort: (columnIndex, ascending) {
              orderVM.sort<num>(
                (order) => order.totalPrice ?? 0,
                columnIndex,
                ascending,
              );
            },
          ),

          // Source
          DataColumn(
            label: SizedBox(
              height: 22,
              width: 120,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Source',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  suffixIcon: Icon(Iconsax.sort_copy, size: 20),
                ),
                controller: orderVM.source,
                onChanged: (val) => orderVM.applyFilter('source', val),
              ),
            ),
            onSort: (columnIndex, ascending) {
              orderVM.sort<String>(
                (order) => order.orderSource ?? '',
                columnIndex,
                ascending,
              );
            },
          ),

          // Actions
          const DataColumn(
            label: DefaultText(txt: 'Actions', bold: true),
          ),
        ],
        rows: orderVM.orders
            .map((order) => _buildDataRow(context, order))
            .toList(),
      ),
    );
  }

  // This is the native Flutter DataRow
  DataRow _buildDataRow(BuildContext context, OrderModel order) {
    return DataRow(
      cells: [
        DataCell(Text('#${order.orderId}')),
        DataCell(Text(DateHelper.formatDatePicker(order.orderDate.toString()))),
        DataCell(Text(order.customer?.fullName ?? "-", style: const TextStyle(fontWeight: FontWeight.bold),)),
        DataCell(Text(order.customer?.phone ?? "-")),
        DataCell(
          SizedBox(
            width: 130,
            height: 25,
            child: OrderStatusDropdown(
              currentStatus: order.status.toString(),
              onStatusChanged: (state) {
                order.status = state;
              },
              order: order,
            ),
          ),
        ),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateOrder(
                  existingOrder: order,
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Iconsax.trash_copy, size: 20, color: Colors.red),
          onPressed: !Provider.of<OrderVM>(context).isSaving
              ? () async => _deleteOrder(context, order, addOrderVM,
                  Provider.of<OrderVM>(context, listen: false))
              : null,
        ),
      ],
    );
  }

  Future<void> _deleteOrder(
    BuildContext context,
    OrderModel order,
    AddOrderVM orderVM,
    OrderVM provider,
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

    await provider.deleteOrder(order.orderId!);
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
    "Processing",
    "Shipped",
    "Canceled",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: currentStatus == "Pending"
            ? Colors.yellow.shade800
            : currentStatus == "Completed"
                ? Colors.green.shade300
                : currentStatus == "Processing"
                    ? Colors.blue.shade300
                    : currentStatus == "Canceled"
                        ? Colors.red.shade300
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
            if (value == null) return;
            if (value == "Completed") {
              final bankAccount = await showTransferDialog(context, order.totalPrice ?? 0);
              if(bankAccount != null){
                final state = await Provider.of<OrderVM>(context, listen: false)
                    .updateOrderStatus(
                    orderID: order.orderId.toString(),
                    statusValue: value,
                    bankAccountId: bankAccount.id.toString()
                );
                if (state == "status_updated") {
                  onStatusChanged(value);
                  Provider.of<AccountingVM>(context, listen: false).initAccounting();
                }
              }
            } else {
              final state = await Provider.of<OrderVM>(context, listen: false)
                  .updateOrderStatus(
                  orderID: order.orderId.toString(),
                  statusValue: value,
                  bankAccountId: "0"
              );
              if (state == "status_updated") {
                onStatusChanged(value);
                Provider.of<AccountingVM>(context, listen: false).initAccounting();
              }
            }
          },
        ),
      ),
    );
  }
}

Future<BankAccount?> showTransferDialog(BuildContext context, double totalPrice) async {
  BankAccount? selectedAccount;

  final bool? result = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Confirm Completion'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black87,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(text: 'Once the order is completed, the payment ', style: TextStyle(fontSize: 16)),
                  TextSpan(
                    text: '$totalPrice EGP',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const TextSpan(
                      text:
                      ' will be transferred.\n\n',  style: TextStyle(fontSize: 16)),
                  const TextSpan(text: 'Select the account to transfer your money to:'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Consumer<AccountingVM>(
              builder: (context, accounting, child) => accounting.accountsBalance == null ? Container() : DropdownButtonFormField<BankAccount>(
                initialValue: selectedAccount,
                hint: const Text('Choose account'),
                items:
                  accounting.accountsBalance!
                      .map((account) => DropdownMenuItem<BankAccount>(
                    value: account,
                    child: Text(account.name),
                  ))
                      .toList(),
                onChanged: (value) => setState(() => selectedAccount = value),
                borderRadius: Constants.BORDER_RADIUS_20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                  Colors.grey.shade100,
                  labelStyle:
                  const TextStyle(color: Colors.grey, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: Constants.BORDER_RADIUS_15),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      Iconsax.bank_copy,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.grey.shade500),
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: selectedAccount == null
                ? null
                : () => Navigator.pop(context, true),
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              backgroundColor:
              WidgetStateProperty.all<Color>(Colors.green.shade400),
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    ),
  );

  if (result == true && selectedAccount != null) {

    return selectedAccount;
  }
  return null;
}

