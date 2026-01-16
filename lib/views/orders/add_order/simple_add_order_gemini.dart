// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:warsha_app/controllers/add_order/add_payment.dart';
// import 'package:warsha_app/models/account_balance.dart';
// import 'package:warsha_app/models/create_order_request.dart';
// import 'package:warsha_app/models/product_model.dart';
// import 'package:warsha_app/models/orderItemModel.dart';
// import 'package:warsha_app/models/customerModel.dart';
// import 'package:warsha_app/view_models/accountings_v_m.dart';
// import 'package:warsha_app/view_models/customers_v_m.dart';
// import 'package:warsha_app/view_models/add_product_v_m.dart';
// import 'package:warsha_app/view_models/add_order_v_m.dart';
// import 'package:warsha_app/view_models/order_v_m.dart';
//
// class SimpleAddOrder extends StatefulWidget {
//   const SimpleAddOrder({super.key});
//
//   @override
//   State<SimpleAddOrder> createState() => _SimpleAddOrderState();
// }
//
// class _SimpleAddOrderState extends State<SimpleAddOrder> {
//   // Temporary state for the "Add Item" row
//   ProductModel? _selectedProduct;
//   final TextEditingController _qtyController = TextEditingController(text: '1');
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   // Your Brand Color
//   final Color _brandColor = const Color(0xFF8E515D);
//
//   @override
//   void dispose() {
//     _qtyController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('New Order', style: TextStyle(fontSize: 18)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//         actions: [
//           // Reset Button
//           IconButton(
//             icon: const Icon(Iconsax.refresh),
//             onPressed: () {
//               // Add logic to clear the view model
//               Provider.of<AddOrderVM>(context, listen: false).orderModel.orderItems.clear();
//               setState(() {});
//             },
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // 1. Customer Selection (Simple Dropdown)
//             _buildCustomerDropdown(context),
//
//             const SizedBox(height: 20),
//             const Divider(),
//             const SizedBox(height: 10),
//
//             // 2. Add Product Row
//             Text(
//               "Add Items",
//               style: TextStyle(
//                   color: _brandColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14
//               ),
//             ),
//             const SizedBox(height: 10),
//             _buildAddProductRow(context),
//
//             const SizedBox(height: 20),
//
//             // 3. Order Items List (The "Cart")
//             Expanded(
//               child: _buildOrderItemsList(context),
//             ),
//
//             // 4. Footer (Total & Save)
//             _buildFooter(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCustomerDropdown(BuildContext context) {
//     return Consumer<CustomerVM>(
//       builder: (context, customerVM, child) {
//         return FutureBuilder<List<CustomerModel>>(
//           future: customerVM.allCustomers,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) return const LinearProgressIndicator();
//
//             return DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 labelText: 'Select Customer',
//                 prefixIcon: const Icon(Iconsax.user),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               ),
//               items: snapshot.data!.map((customer) {
//                 return DropdownMenuItem(
//                   value: customer.customerId.toString(),
//                   child: Text(
//                       customer.fullName,
//                       overflow: TextOverflow.ellipsis
//                   ),
//                 );
//               }).toList(),
//               onChanged: (val) {
//                 if (val != null) {
//                   final selected = snapshot.data!.firstWhere((c) => c.customerId.toString() == val);
//                   Provider.of<AddOrderVM>(context, listen: false).addCustomer = selected;
//                 }
//               },
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildAddProductRow(BuildContext context) {
//     return Consumer<ProductVM>(
//       builder: (context, productVM, child) {
//         return FutureBuilder<List<ProductModel>>(
//           future: productVM.allProducts,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) return const SizedBox();
//
//             return Form(
//               key: _formKey,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Product Dropdown
//                   Expanded(
//                     flex: 3,
//                     child: DropdownButtonFormField<ProductModel>(
//                       value: _selectedProduct,
//                       isExpanded: true,
//                       decoration: InputDecoration(
//                         labelText: 'Product',
//                         hintText: 'Choose...',
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//                       ),
//                       items: snapshot.data!.map((product) {
//                         return DropdownMenuItem(
//                           value: product,
//                           child: Text(
//                             product.name,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontSize: 13),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           _selectedProduct = val;
//                         });
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//
//                   // Quantity Field
//                   Expanded(
//                     flex: 1,
//                     child: TextFormField(
//                       controller: _qtyController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Qty',
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//                       ),
//                       validator: (val) {
//                         if (val == null || val.isEmpty) return 'Req';
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//
//                   // Add Button
//                   SizedBox(
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () => _handleAddProduct(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: _brandColor,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       ),
//                       child: const Icon(Icons.add),
//                     ),
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
//   void _handleAddProduct(BuildContext context) {
//     if (_selectedProduct == null) return;
//     if (!_formKey.currentState!.validate()) return;
//
//     final qty = int.tryParse(_qtyController.text) ?? 1;
//
//     final item = OrderItemModel(
//       productId: int.parse(_selectedProduct!.id),
//       productName: _selectedProduct!.name,
//       quantity: qty,
//       unitPrice: double.parse(_selectedProduct!.sellingPrice),
//     );
//
//     Provider.of<AddOrderVM>(context, listen: false).addToOrderItems = item;
//
//     // Reset fields for next entry
//     setState(() {
//       _selectedProduct = null;
//       _qtyController.text = '1';
//     });
//   }
//
//   Widget _buildOrderItemsList(BuildContext context) {
//     return Consumer<AddOrderVM>(
//       builder: (context, orderVM, child) {
//         final items = orderVM.orderModel.orderItems;
//
//         if (items.isEmpty) {
//           return Center(
//             child: Text(
//               "No items added yet",
//               style: TextStyle(color: Colors.grey.shade400),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             final item = items[index];
//             final total = item.unitPrice * item.quantity;
//
//             return Container(
//               margin: const EdgeInsets.only(bottom: 8),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade200),
//               ),
//               child: ListTile(
//                 dense: true,
//                 title: Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w600)),
//                 subtitle: Text("${item.quantity} x ${item.unitPrice} EGP"),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "${total.toStringAsFixed(1)} EGP",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: _brandColor
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, size: 16, color: Colors.grey),
//                       onPressed: () {
//                         orderVM.removeFromOrderItems = item.productId;
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildFooter(BuildContext context) {
//     return Consumer<AddOrderVM>(
//       builder: (context, orderVM, child) {
//         final items = orderVM.orderModel.orderItems;
//         final total = items.fold<double>(0, (sum, item) => sum + (item.quantity * item.unitPrice));
//         final canSave = items.isNotEmpty && orderVM.orderModel.customerId != null;
//
//         return Column(
//           children: [
//             const Divider(),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Total Amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   Text(
//                     "${total.toStringAsFixed(2)} EGP",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _brandColor),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: canSave ? () {
//                   // Navigate to Next Step or Save
//                 } : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _brandColor,
//                   foregroundColor: Colors.white,
//                   disabledBackgroundColor: Colors.grey.shade300,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text("Create Order", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class SimpleOrderDetailsStep extends StatefulWidget {
//   const SimpleOrderDetailsStep({super.key});
//
//   @override
//   State<SimpleOrderDetailsStep> createState() => _SimpleOrderDetailsStepState();
// }
//
// class _SimpleOrderDetailsStepState extends State<SimpleOrderDetailsStep> {
//   final _formKey = GlobalKey<FormState>();
//   final Color _brandColor = const Color(0xFF8E515D);
//
//   // Local state for Bank Account selection to replace the dialog
//   BankAccount? _selectedBankAccount;
//
//   @override
//   void initState() {
//     super.initState();
//     // Ensure Accounting data (banks) is loaded
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<AccountingVM>(context, listen: false).initAccounting();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         title: const Text('Payment & Confirmation', style: TextStyle(fontSize: 18, color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: Consumer2<AddOrderVM, PaymentProvider>(
//         builder: (context, addOrderVM, payment, child) {
//           final double itemsTotal = addOrderVM.getTotalPrice();
//           // Calculate Net Total dynamically based on inputs
//           double delivery = double.tryParse(payment.delivery.text) ?? 0.0;
//           double discount = double.tryParse(payment.discount.text) ?? 0.0;
//           double finalTotal = (itemsTotal + delivery) - discount;
//
//           return Form(
//             key: _formKey,
//             child: ListView(
//               padding: const EdgeInsets.all(20),
//               children: [
//                 // 1. Order Summary Card
//                 _buildSummaryCard(itemsTotal, finalTotal, payment),
//
//                 const SizedBox(height: 24),
//
//                 // 2. Financial Details Form
//                 const Text("Financial Details", style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 12),
//
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildMoneyField(
//                         controller: payment.delivery,
//                         label: 'Delivery Cost',
//                         icon: Iconsax.truck,
//                         onChanged: (_) => setState((){}), // Trigger rebuild for total calc
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _buildMoneyField(
//                         controller: payment.discount,
//                         label: 'Discount',
//                         icon: Iconsax.discount_shape,
//                         color: Colors.red.shade700,
//                         onChanged: (_) => setState((){}),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//
//                 _buildMoneyField(
//                   controller: payment.downPayment,
//                   label: 'Down Payment (Deposit)',
//                   icon: Iconsax.money_change,
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // 3. Payment Method & Source
//                 const Text("Payment Information", style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 12),
//
//                 _buildDropdownField(
//                   controller: payment.paymentMethod,
//                   label: 'Payment Method',
//                   icon: Iconsax.card,
//                   items: ['Cash', 'Visa', 'Instapay', 'Vodafone Cash'],
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 _buildDropdownField(
//                   controller: payment.platformSource,
//                   label: 'Order Source',
//                   icon: Iconsax.global,
//                   items: ['Facebook', 'Instagram', 'Whatsapp', 'Website', 'Store'],
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // 4. Bank Account Selection (Replaces the Dialog)
//                 _buildBankAccountDropdown(),
//
//                 const SizedBox(height: 12),
//
//                 TextFormField(
//                   controller: payment.notes,
//                   maxLines: 3,
//                   decoration: InputDecoration(
//                     labelText: 'Order Notes',
//                     prefixIcon: const Icon(Iconsax.note),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // 5. Submit Button
//                 _buildSubmitButton(context, addOrderVM, payment, finalTotal),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildSummaryCard(double itemsTotal, double finalTotal, PaymentProvider payment) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade200),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         children: [
//           _summaryRow("Subtotal", itemsTotal),
//           const SizedBox(height: 8),
//           _summaryRow("Delivery", double.tryParse(payment.delivery.text) ?? 0.0),
//           _summaryRow("Discount", double.tryParse(payment.discount.text) ?? 0.0, isNegative: true),
//           const Divider(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text("Net Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               Text(
//                 "${finalTotal.toStringAsFixed(2)} EGP",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: _brandColor),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMoneyField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     Color? color,
//     Function(String)? onChanged,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: const TextInputType.numberWithOptions(decimal: true),
//       onChanged: onChanged,
//       style: TextStyle(color: color ?? Colors.black),
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: color ?? Colors.grey.shade600),
//         suffixText: 'EGP',
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       ),
//     );
//   }
//
//   Widget _buildDropdownField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     required List<String> items,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: items.contains(controller.text) ? controller.text : null,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         filled: true,
//         fillColor: Colors.white,
//       ),
//       items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//       onChanged: (val) {
//         if (val != null) controller.text = val;
//       },
//       validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//     );
//   }
//
//   Widget _buildBankAccountDropdown() {
//     return Consumer<AccountingVM>(
//       builder: (context, accountingVM, child) {
//         // 1. Get the list directly from the VM
//         // Change 'accountsBalance' to whatever your list variable is named in the VM
//         // (e.g., bankAccounts, allAccounts, etc.)
//         final banks = accountingVM.accountsBalance;
//
//         // 2. Show loading if list is empty (assuming fetch is happening)
//         if (banks == null || banks.isEmpty) {
//           return const Center(child: LinearProgressIndicator());
//         }
//
//         // 3. Validation: Ensure the selected value actually exists in the current list
//         // This prevents the "There should be exactly one item with [DropdownButton]'s value" error
//         if (_selectedBankAccount != null &&
//             !banks.any((b) => b.id == _selectedBankAccount!.id)) {
//           _selectedBankAccount = null;
//         }
//
//         return DropdownButtonFormField<BankAccount>(
//           value: _selectedBankAccount,
//           decoration: InputDecoration(
//             labelText: 'Deposit To Account',
//             prefixIcon: const Icon(Iconsax.bank),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//             filled: true,
//             fillColor: Colors.white,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           ),
//           // 4. Map the list safely
//           items: banks.map((account) {
//             return DropdownMenuItem<BankAccount>(
//               value: account,
//               child: Text(
//                 // Handle potential null names
//                 account.name.isNotEmpty == true ? account.name : "Bank #${account.id}",
//                 overflow: TextOverflow.ellipsis,
//               ),
//             );
//           }).toList(),
//           onChanged: (val) {
//             setState(() {
//               _selectedBankAccount = val;
//             });
//           },
//           validator: (val) => val == null ? 'Please select a bank account' : null,
//         );
//       },
//     );
//   }
//
//   Widget _buildSubmitButton(
//       BuildContext context, AddOrderVM addOrderVM, PaymentProvider payment, double finalTotal) {
//
//     final orderVM = context.watch<OrderVM>();
//
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: orderVM.isSaving ? null : () async {
//           if (!_formKey.currentState!.validate()) return;
//           if (_selectedBankAccount == null) {
//             _showError('Please select a bank account for the deposit');
//             return;
//           }
//
//           try {
//             // Map items
//             final itemsToCreate = addOrderVM.orderModel.orderItems.map((item) {
//               return CreateOrderItem(
//                 productId: item.productId,
//                 quantity: item.quantity,
//                 unitPrice: item.unitPrice,
//               );
//             }).toList();
//
//             final request = CreateOrderRequest(
//               customerId: addOrderVM.orderModel.customer!.customerId,
//               delivery: double.tryParse(payment.delivery.text) ?? 0,
//               discount: double.tryParse(payment.discount.text) ?? 0,
//               downPayment: payment.downPayment.text,
//               notes: payment.notes.text,
//               orderSource: payment.platformSource.text,
//               paymentMethod: payment.paymentMethod.text,
//               items: itemsToCreate,
//               bankAccountId: _selectedBankAccount!.id.toString(),
//             );
//
//             final success = await context.read<OrderVM>().addOrder(request);
//
//             if (success && context.mounted) {
//               // Refresh & Cleanup
//               context.read<ProductVM>().initAllProducts();
//               context.read<AccountingVM>().initAccounting();
//               payment.clearPaymentDetails();
//               addOrderVM.clearOrder();
//
//               Navigator.pop(context); // Pop details
//               Navigator.pop(context); // Pop main add screen
//
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Order #$success placed successfully'), // Assuming success returns ID or bool
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             } else if (context.mounted) {
//               _showError(orderVM.errorMessage);
//             }
//           } catch (e) {
//             _showError(e.toString());
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _brandColor,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           elevation: 2,
//         ),
//         child: orderVM.isSaving
//             ? const CircularProgressIndicator(color: Colors.white)
//             : Text("Confirm Order (${finalTotal.toStringAsFixed(2)} EGP)",
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
//
//   Widget _summaryRow(String label, double amount, {bool isNegative = false}) {
//     if (amount == 0) return const SizedBox.shrink();
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
//           Text(
//             "${isNegative ? '-' : ''}${amount.toStringAsFixed(2)}",
//             style: TextStyle(
//               color: isNegative ? Colors.red : Colors.black87,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showError(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(msg), backgroundColor: Colors.red),
//     );
//   }
// }