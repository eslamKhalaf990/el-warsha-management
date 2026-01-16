// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:warsha_app/models/product_model.dart';
// import 'package:warsha_app/models/orderItemModel.dart';
// import 'package:warsha_app/models/customerModel.dart';
// import 'package:warsha_app/view_models/customers_v_m.dart';
// import 'package:warsha_app/view_models/add_product_v_m.dart';
// import 'package:warsha_app/view_models/add_order_v_m.dart';
// import 'package:warsha_app/utils/deafualt_form_field.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:warsha_app/views/orders/add_order/customer_to_add.dart';
// // Import your other widgets...
//
// class ClaudeAddOrder extends StatelessWidget {
//   const ClaudeAddOrder({super.key});
//
//   // Your Brand Color
//   static const Color primaryColor = Color(0xFF8E515D);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.transparent,
//         elevation: 0,
//         shape: Border(bottom: BorderSide(color: Colors.grey.shade200)),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Create Sales Order',
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
//         ),
//         actions: [
//           TextButton.icon(
//             onPressed: () {
//               // Save draft logic
//             },
//             icon: Icon(Iconsax.save_2, size: 18, color: primaryColor),
//             label: Text('Save Draft', style: TextStyle(color: primaryColor)),
//           ),
//           const SizedBox(width: 16),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Responsive Breakpoint: 900px
//           bool isDesktop = constraints.maxWidth > 900;
//
//           if (isDesktop) {
//             return Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 7,
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(24),
//                     child: _buildMainContent(context),
//                   ),
//                 ),
//                 Container(
//                   width: 380, // Slightly wider for better readability
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                         left: BorderSide(color: Colors.grey.shade200)),
//                   ),
//                   child: _buildOrderSummary(context),
//                 ),
//               ],
//             );
//           } else {
//             // Mobile/Tablet Layout
//             return Stack(
//               children: [
//                 SingleChildScrollView(
//                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
//                   child: _buildMainContent(context),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: _buildMobileSummaryBar(context),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildMainContent(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader(context, 'Customer Information', isRequired: true),
//         const SizedBox(height: 16),
//         _buildCustomerSelection(context),
//         const SizedBox(height: 32),
//         _buildSectionHeader(context, 'Product Catalog', isRequired: true),
//         const SizedBox(height: 16),
//         _buildProductsSelection(context),
//       ],
//     );
//   }
//
//   Widget _buildSectionHeader(BuildContext context, String title,
//       {bool isRequired = false}) {
//     return Row(
//       children: [
//         Container(
//           height: 24,
//           width: 4,
//           decoration: BoxDecoration(
//             color: primaryColor,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           title,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         if (isRequired)
//           const Text(' *', style: TextStyle(color: Colors.red, fontSize: 16)),
//       ],
//     );
//   }
//
//   Widget _buildCustomerSelection(BuildContext context) {
//     return Consumer<AddOrderVM>(
//       builder: (context, orderVM, child) {
//         bool hasCustomer = orderVM.orderModel.customerId != null;
//
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//                 color: hasCustomer ? primaryColor : Colors.grey.shade200),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.03),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               if (!hasCustomer)
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: DefaultForm(
//                           title: 'Search by Name or Phone...',
//                           controller: Provider.of<CustomerVM>(context, listen: false)
//                               .searchController,
//                           numberOfLines: 1,
//                           // prefixIcon: const Icon(Iconsax.search_normal),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       ElevatedButton.icon(
//                         onPressed: () {},
//                         icon: const Icon(Icons.add, size: 18),
//                         label: const Text('New Customer'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black87,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 16),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               if (hasCustomer) ...[
//                 Consumer<CustomerVM>(
//                   builder: (context, customerVM, child) {
//                     return FutureBuilder<List<CustomerModel>>(
//                       future: customerVM.allCustomers,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           // Safe handling if customer not found in list
//                           try {
//                             final customer = snapshot.data!.firstWhere(
//                                   (c) => c.customerId == orderVM.orderModel.customerId,
//                             );
//                             return _buildSelectedCustomerCard(context, customer);
//                           } catch (e) {
//                             return const SizedBox();
//                           }
//                         }
//                         return const LinearProgressIndicator();
//                       },
//                     );
//                   },
//                 ),
//               ] else
//                 SizedBox(
//                   height: 220,
//                   child: const CustomerToAdd(),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildSelectedCustomerCard(BuildContext context, CustomerModel customer) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 24,
//             backgroundColor: primaryColor.withOpacity(0.1),
//             child: Text(
//               customer.fullName.substring(0, 1).toUpperCase(),
//               style: TextStyle(
//                   fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   customer.fullName,
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Iconsax.call, size: 14, color: Colors.grey.shade600),
//                     const SizedBox(width: 4),
//                     Text(customer.phone,
//                         style: TextStyle(color: Colors.grey.shade600)),
//                     const SizedBox(width: 12),
//                     Icon(Iconsax.location, size: 14, color: Colors.grey.shade600),
//                     const SizedBox(width: 4),
//                     Text(customer.governorate,
//                         style: TextStyle(color: Colors.grey.shade600)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               // Add logic to clear customer
//               // Provider.of<AddOrderVM>(context, listen: false).clearCustomer();
//             },
//             icon: const Icon(Iconsax.close_circle, color: Colors.red),
//             tooltip: 'Remove Customer',
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductsSelection(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: DefaultForm(
//               title: 'Search Products (Name, SKU)...',
//               controller: Provider.of<ProductVM>(context, listen: false).searchController,
//               numberOfLines: 1,
//               // Add a clear button logic if needed
//             ),
//           ),
//           const Divider(height: 1),
//           const SizedBox(
//             height: 500, // Fixed height for scrolling list
//             child: ProductToAdd(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // --- Right Sidebar / Bottom Sheet Components ---
//
//   Widget _buildOrderSummary(BuildContext context) {
//     return Consumer<AddOrderVM>(
//       builder: (context, orderVM, child) {
//         final items = orderVM.orderModel.orderItems;
//         final subtotal = items.fold<double>(
//           0,
//               (sum, item) => sum + (item.unitPrice * item.quantity),
//         );
//
//         return Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
//               ),
//               child: const Row(
//                 children: [
//                   Icon(Iconsax.shopping_cart, size: 20),
//                   SizedBox(width: 12),
//                   Text(
//                     'Current Order',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: items.isEmpty
//                   ? _buildEmptyCartState()
//                   : ListView.separated(
//                 padding: const EdgeInsets.all(20),
//                 itemCount: items.length,
//                 separatorBuilder: (_, __) => const Divider(height: 24),
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   return _buildSummaryItem(context, item, orderVM);
//                 },
//               ),
//             ),
//             _buildTotalsSection(context, subtotal, items.isNotEmpty),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildEmptyCartState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade50,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(Iconsax.bag_2, size: 40, color: Colors.grey.shade300),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Cart is empty',
//             style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500),
//           ),
//           Text(
//             'Select products from the list',
//             style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSummaryItem(
//       BuildContext context, OrderItemModel item, AddOrderVM orderVM) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Optional: Add small thumbnail here if available
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 item.productName,
//                 style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 '${item.unitPrice} EGP / unit',
//                 style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
//               ),
//             ],
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${(item.unitPrice * item.quantity).toStringAsFixed(2)} EGP',
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//             ),
//             const SizedBox(height: 8),
//             // Quantity Controls
//             Container(
//               height: 32,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _qtyBtn(Icons.remove, () {
//                     if (item.quantity > 1) {
//                       // Update logic: In a real app, create a new model with qty - 1
//                       // Since we don't have an 'update' method in your VM provided,
//                       // we mimic it by removing and re-adding (dirty fix)
//                       // OR assuming you implement `updateQuantity` in VM.
//                       // Ideally: orderVM.updateItemQuantity(item.productId, item.quantity - 1);
//                     } else {
//                       orderVM.removeFromOrderItems = item.productId;
//                     }
//                   }),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Text('${item.quantity}',
//                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
//                   ),
//                   _qtyBtn(Icons.add, () {
//                     // orderVM.updateItemQuantity(item.productId, item.quantity + 1);
//                   }),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _qtyBtn(IconData icon, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//         child: Icon(icon, size: 14, color: Colors.black54),
//       ),
//     );
//   }
//
//   Widget _buildTotalsSection(BuildContext context, double subtotal, bool hasItems) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         border: Border(top: BorderSide(color: Colors.grey.shade200)),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text('Total Amount',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               Text(
//                 '${subtotal.toStringAsFixed(2)} EGP',
//                 style: TextStyle(
//                     fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: hasItems ? () {
//                 // Navigation logic
//               } : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 elevation: 0,
//               ),
//               child: const Text('Confirm Order', style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileSummaryBar(BuildContext context) {
//     // A simplified floating bar for mobile
//     return Consumer<AddOrderVM>(
//       builder: (context, orderVM, child) {
//         final items = orderVM.orderModel.orderItems;
//         final subtotal = items.fold<double>(0, (s, i) => s + (i.unitPrice * i.quantity));
//
//         if (items.isEmpty) return const SizedBox();
//
//         return Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
//           ),
//           child: Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('${items.length} Items', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
//                   Text('${subtotal.toStringAsFixed(2)} EGP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primaryColor)),
//                 ],
//               ),
//               const Spacer(),
//               ElevatedButton(
//                 onPressed: () {
//                   showModalBottomSheet(
//                       context: context,
//                       builder: (_) => SizedBox(height: 500, child: _buildOrderSummary(context))
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white),
//                 child: const Text('View Cart'),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ProductToAdd extends StatelessWidget {
//   const ProductToAdd({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Trigger initial load if needed
//     // Provider.of<ProductVM>(context, listen: false).fetchAllProducts();
//
//     return FutureBuilder<List<ProductModel>>(
//       future: Provider.of<ProductVM>(context).allProducts,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(strokeWidth: 2));
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error loading products', style: TextStyle(color: Colors.red.shade300)));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No products available'));
//         }
//
//         final filteredProducts = snapshot.data!.where((product) {
//           final query = Provider.of<ProductVM>(context).searchController.text.toLowerCase();
//           return product.name.toLowerCase().contains(query) ||
//               (product.sku?.toLowerCase().contains(query) ?? false);
//         }).toList();
//
//         if (filteredProducts.isEmpty) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Iconsax.search_normal, size: 40, color: Colors.grey.shade300),
//               const SizedBox(height: 8),
//               // Text('No products match "$query"', style: TextStyle(color: Colors.grey.shade500)),
//             ],
//           );
//         }
//
//         return Consumer<AddOrderVM>(
//           builder: (context, orderVM, child) {
//             return ListView.separated(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               itemCount: filteredProducts.length,
//               separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
//               itemBuilder: (context, index) {
//                 final product = filteredProducts[index];
//                 final isSelected = orderVM.orderModel.orderItems
//                     .any((item) => product.id == item.productId.toString());
//                 final stockQty = int.tryParse(product.quantity) ?? 0;
//                 final isOutOfStock = stockQty < 1;
//
//                 return Opacity(
//                   opacity: isOutOfStock ? 0.5 : 1.0,
//                   child: InkWell(
//                     onTap: isOutOfStock ? null : () {
//                       if (!isSelected) {
//                         // FIX: Default quantity to 1, not product.quantity (stock)
//                         OrderItemModel orderItemsModel = OrderItemModel(
//                           productId: int.parse(product.id),
//                           quantity: 1,
//                           unitPrice: double.parse(product.sellingPrice),
//                           productName: product.name,
//                         );
//                         orderVM.addToOrderItems = orderItemsModel;
//                       } else {
//                         // Optional: Show snackbar "Item removed"
//                         orderVM.removeFromOrderItems = int.parse(product.id);
//                       }
//                     },
//                     child: Container(
//                       color: isSelected
//                           ? const Color(0xFF8E515D).withOpacity(0.08)
//                           : Colors.transparent,
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       child: ProductWidget(
//                           productModel: product,
//                           isSelected: isSelected,
//                           isOutOfStock: isOutOfStock
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
//
// class ProductWidget extends StatelessWidget {
//   final ProductModel productModel;
//   final bool isSelected;
//   final bool isOutOfStock;
//
//   const ProductWidget({
//     super.key,
//     required this.productModel,
//     this.isSelected = false,
//     this.isOutOfStock = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     const primaryColor = Color(0xFF8E515D);
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Image Container
//         Container(
//           width: 60,
//           height: 60,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           clipBehavior: Clip.antiAlias,
//           child: Image.network(
//             productModel.image,
//             fit: BoxFit.cover,
//             errorBuilder: (_, __, ___) => Icon(Iconsax.image, color: Colors.grey.shade300),
//           ),
//         ),
//         const SizedBox(width: 16),
//
//         // Content
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       productModel.name,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                         color: isSelected ? primaryColor : Colors.black87,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   if (isOutOfStock)
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: Colors.red.shade50,
//                         borderRadius: BorderRadius.circular(4),
//                         border: Border.all(color: Colors.red.shade100),
//                       ),
//                       child: Text(
//                         'Out of Stock',
//                         style: TextStyle(fontSize: 10, color: Colors.red.shade700, fontWeight: FontWeight.bold),
//                       ),
//                     )
//                   else if (isSelected)
//                     Icon(Icons.check_circle, size: 20, color: primaryColor),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'SKU: ${productModel.sku}',
//                 style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
//               ),
//               const SizedBox(height: 6),
//               Row(
//                 children: [
//                   _priceTag(context, 'Buy', productModel.buyingPrice, Colors.green),
//                   const SizedBox(width: 8),
//                   _priceTag(context, 'Sell', productModel.sellingPrice, Theme.of(context).colorScheme.tertiary),
//                   const Spacer(),
//                   Text(
//                     '${productModel.quantity} in stock',
//                     style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _priceTag(BuildContext context, String label, String price, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: RichText(
//         text: TextSpan(
//           style: TextStyle(fontSize: 11, color: color.withOpacity(0.8)),
//           children: [
//             TextSpan(text: '$label: '),
//             TextSpan(
//                 text: price,
//                 style: TextStyle(fontWeight: FontWeight.bold, color: color)
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
