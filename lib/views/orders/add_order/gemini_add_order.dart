// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:warsha_app/models/customerModel.dart';
// import 'package:warsha_app/models/orderItemModel.dart';
// import 'package:warsha_app/models/product_model.dart';
// import 'package:warsha_app/view_models/add_order_v_m.dart';
// import 'package:warsha_app/view_models/add_product_v_m.dart';
// import 'package:warsha_app/view_models/customers_v_m.dart';
// import 'package:warsha_app/views/orders/add_order/order_details.dart';
// import '../../products/product_widget.dart';
// import '../customer_widget.dart';
//
// class GeminiAddOrder extends StatelessWidget {
//   const GeminiAddOrder({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("New Order"),
//         elevation: 0,
//         backgroundColor: Theme.of(context).colorScheme.surface,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 // If width is less than 600, use Mobile Layout (Tabs)
//                 if (constraints.maxWidth < 800) {
//                   return const _MobileLayout();
//                 } else {
//                   // Otherwise use Desktop/Tablet Layout (Split View)
//                   return const _DesktopLayout();
//                 }
//               },
//             ),
//           ),
//           // Persistent Bottom Bar for Summary & Action
//           const _OrderSummaryBottomBar(),
//         ],
//       ),
//     );
//   }
// }
//
// // Mobile: Uses Tabs to switch views
// class _MobileLayout extends StatelessWidget {
//   const _MobileLayout();
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Column(
//         children: [
//           TabBar(
//             labelColor: Theme.of(context).primaryColor,
//             unselectedLabelColor: Colors.grey,
//             indicatorColor: Theme.of(context).primaryColor,
//             tabs: const [
//               Tab(icon: Icon(Icons.inventory_2), text: "Select Products"),
//               Tab(icon: Icon(Icons.person), text: "Select Customer"),
//             ],
//           ),
//           const Expanded(
//             child: TabBarView(
//               children: [
//                 ProductSelectionView(),
//                 CustomerSelectionView(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Desktop: Side-by-Side
// class _DesktopLayout extends StatelessWidget {
//   const _DesktopLayout();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 1,
//           child: Container(
//             margin: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.surface,
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: Colors.grey.withOpacity(0.2)),
//             ),
//             child: const ProductSelectionView(),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Container(
//             margin: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.surface,
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: Colors.grey.withOpacity(0.2)),
//             ),
//             child: const CustomerSelectionView(),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _OrderSummaryBottomBar extends StatelessWidget {
//   const _OrderSummaryBottomBar();
//
//   @override
//   Widget build(BuildContext context) {
//     // Listen to changes in AddOrderVM to update counts/names
//     return Consumer<AddOrderVM>(
//       builder: (context, orderVM, child) {
//         final itemCount = orderVM.orderModel.orderItems.length;
//         // final customerName = orderVM.?.fullName ?? "No Customer Selected";
//
//         return Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surface,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, -5),
//               )
//             ],
//           ),
//           child: SafeArea(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "$itemCount Items in Cart",
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     // Text(
//                     //   "Client: $customerName",
//                     //   style: TextStyle(
//                     //     fontSize: 12,
//                     //     color: orderVM.addCustomer == null ? Colors.red : Colors.grey[700],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).primaryColor,
//                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const OrderDetailsStep()),
//                     );
//                   }, // Disable if invalid
//                   child: const Text("Continue", style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ProductSelectionView extends StatefulWidget {
//   const ProductSelectionView({super.key});
//
//   @override
//   State<ProductSelectionView> createState() => _ProductSelectionViewState();
// }
//
// class _ProductSelectionViewState extends State<ProductSelectionView> {
//   @override
//   Widget build(BuildContext context) {
//     // Access ProductVM
//     final productVM = Provider.of<ProductVM>(context);
//
//     return Column(
//       children: [
//         // Search Header
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: TextField(
//             controller: productVM.searchController,
//             decoration: InputDecoration(
//               hintText: "Search Products...",
//               prefixIcon: const Icon(Icons.search),
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               filled: true,
//               fillColor: Colors.grey[100],
//             ),
//             onChanged: (val) => setState(() {}), // Trigger rebuild to filter list
//           ),
//         ),
//         // List
//         Expanded(
//           child: FutureBuilder<List<ProductModel>>(
//             future: productVM.allProducts,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//
//                 // Filtering Logic
//                 final query = productVM.searchController.text.toLowerCase();
//                 final filteredProducts = snapshot.data!.where((product) {
//                   final name = product.name.toLowerCase();
//                   final sku = product.sku?.toLowerCase() ?? "";
//                   return name.contains(query) || sku.contains(query);
//                 }).toList();
//
//                 if (filteredProducts.isEmpty) {
//                   return const Center(child: Text("No products match your search"));
//                 }
//
//                 return ListView.builder(
//                   itemCount: filteredProducts.length,
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   itemBuilder: (context, index) {
//                     final product = filteredProducts[index];
//                     return _SelectableProductItem(product: product);
//                   },
//                 );
//               } else {
//                 return const Center(child: Text("No products available"));
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // Wrapper to handle selection visual state
// class _SelectableProductItem extends StatelessWidget {
//   final ProductModel product;
//   const _SelectableProductItem({required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     // Use Consumer here so only this specific row rebuilds when AddOrderVM changes
//     return Consumer<AddOrderVM>(
//       builder: (context, orderVM, child) {
//
//         bool isSelected = orderVM.orderModel.orderItems
//             .any((item) => product.id == item.productId.toString());
//
//         return GestureDetector(
//           onTap: () {
//             // Your logic from original code
//             OrderItemModel orderItemsModel = OrderItemModel(
//               productId: int.parse(product.id),
//               quantity: 1, // Default to 1
//               unitPrice: double.parse(product.sellingPrice),
//               productName: product.name,
//             );
//
//             if (!isSelected) {
//               orderVM.addToOrderItems = orderItemsModel;
//             } else {
//               orderVM.removeFromOrderItems = orderItemsModel.productId;
//             }
//           },
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 8),
//             decoration: BoxDecoration(
//               border: isSelected
//                   ? Border.all(color: Theme.of(context).primaryColor, width: 2)
//                   : null,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Stack(
//               children: [
//                 // Your Existing Product Widget
//                 ProductWidget(product: product),
//
//                 // Visual Checkmark Overlay if selected
//                 if (isSelected)
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: CircleAvatar(
//                       backgroundColor: Theme.of(context).primaryColor,
//                       radius: 12,
//                       child: const Icon(Icons.check, size: 16, color: Colors.white),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class CustomerSelectionView extends StatefulWidget {
//   const CustomerSelectionView({super.key});
//
//   @override
//   State<CustomerSelectionView> createState() => _CustomerSelectionViewState();
// }
//
// class _CustomerSelectionViewState extends State<CustomerSelectionView> {
//   @override
//   Widget build(BuildContext context) {
//     final customerVM = Provider.of<CustomerVM>(context);
//
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: TextField(
//             controller: customerVM.searchController,
//             decoration: InputDecoration(
//               hintText: "Search Customers...",
//               prefixIcon: const Icon(Icons.person_search),
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               filled: true,
//               fillColor: Colors.grey[100],
//             ),
//             onChanged: (val) => setState(() {}),
//           ),
//         ),
//         Expanded(
//           child: FutureBuilder<List<CustomerModel>>(
//             future: customerVM.allCustomers,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//
//                 final query = customerVM.searchController.text.toLowerCase();
//                 final filteredCustomers = snapshot.data!.where((customer) {
//                   final name = customer.fullName.toLowerCase();
//                   final phone = customer.phone.toLowerCase();
//                   return name.contains(query) || phone.contains(query);
//                 }).toList();
//
//                 if (filteredCustomers.isEmpty) {
//                   return const Center(child: Text("No customers found"));
//                 }
//
//                 return ListView.builder(
//                   itemCount: filteredCustomers.length,
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   itemBuilder: (context, index) {
//                     return _SelectableCustomerItem(customer: filteredCustomers[index], index: index);
//                   },
//                 );
//               } else {
//                 return const Center(child: Text("No customers yet"));
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _SelectableCustomerItem extends StatelessWidget {
//   final CustomerModel customer;
//   final int index;
//
//   const _SelectableCustomerItem({required this.customer, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AddOrderVM>(
//       builder: (context, orderVM, child) {
//
//         bool isSelected = orderVM.orderModel.customerId == customer.customerId;
//
//         return GestureDetector(
//           onTap: () {
//             // Select customer
//             orderVM.addCustomer = customer;
//           },
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 8),
//             decoration: BoxDecoration(
//               // Highlight entire card if selected
//               color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
//               border: isSelected
//                   ? Border.all(color: Theme.of(context).primaryColor, width: 2)
//                   : null,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: CustomerWidget(
//               index: index,
//               name: customer.fullName,
//               email: customer.governorate, // Mapping from your original code
//               address: customer.address,
//               phone: customer.phone,
//               id: customer.customerId.toString(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }