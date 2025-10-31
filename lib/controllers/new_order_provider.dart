// import 'package:flutter/material.dart';
// import 'package:warsha_app/models/order_model.dart';
// import 'package:warsha_app/order_upgrading/models/orderModel.dart';
//
// class OrdersTableProvider with ChangeNotifier {
//   List<OrderModel> _allOrders = [];
//   List<OrderModel> _displayOrders = [];
//   List<OrderModel> get displayOrders => _displayOrders;
//
//   int? sortColumnIndex;
//   bool sortAscending = true;
//   String? _currentQuery;
//   String? get currentQuery => _currentQuery;
//   String? _searchQuery;
//   String? get searchQuery => _searchQuery;
//
//   // Stores the function that gets the field to sort by
//   Comparable Function(OrderModel)? _sortField;
//
//   /// Sets the master list of orders from the VM.
//   void setOrders(List<OrderModel> orders) {
//     // Basic check to prevent endless rebuild loops
//     if (_allOrders.length != orders.length) {
//       _allOrders = orders;
//       _updateDisplayList();
//     }
//   }
//
//   void clear (){
//     _allOrders = [];
//     _displayOrders = [];
//     notifyListeners();
//   }
//
//   /// Sets the master list of orders from the VM.
//   void updateOrders() {
//     // Basic check to prevent endless rebuild loops
//
//       _updateDisplayList();
//
//   }
//
//   /// Sets the filter query from the GovernorateProvider.
//   void setFilter(String? query) {
//     if (_currentQuery != query) {
//       _currentQuery = query;
//       _updateDisplayList();
//     }
//   }
//
//   /// Sets the filter query from the GovernorateProvider.
//   void setSearch(String? query) {
//     if (_searchQuery != query) {
//       _searchQuery = query;
//       _updateDisplayList();
//     }
//   }
//
//   /// Sets the sorting parameters and triggers an update.
//   void sort<T>(
//       Comparable<T> Function(OrderModel order) getField,
//       int columnIndex,
//       bool ascending,
//       ) {
//     sortColumnIndex = columnIndex;
//     sortAscending = ascending;
//     _sortField = getField;
//     _updateDisplayList();
//   }
//
//   /// The main logic.
//   /// This is called whenever the data, filter, or sort changes.
// // *** UPDATED ***: The main filter logic
//   void _updateDisplayList() {
//     // Start with the full list
//     List<OrderModel> tempFilteredList = List.from(_allOrders);
//
//     // 1. Apply Category Filter (from GovernorateProvider)
//     if (_currentQuery != null && _currentQuery!.isNotEmpty) {
//       final query = _currentQuery!.toLowerCase();
//       tempFilteredList = tempFilteredList.where((order) {
//         // This is your original filter logic
//         final governorate = order.customer.governorate.toLowerCase();
//         final status = order.status.toLowerCase();
//         final source = order.orderSource.toLowerCase();
//         final payment = order.paymentMethod.toLowerCase();
//
//         return governorate.contains(query) ||
//             status.contains(query) ||
//             source.contains(query) ||
//             payment.contains(query);
//       }).toList();
//     }
//
//     // 2. Apply Search Filter (from Search Bar)
//     // This is applied *after* the category filter (an AND condition)
//     if (_searchQuery != null && _searchQuery!.isNotEmpty) {
//       final query = _searchQuery!.toLowerCase();
//       tempFilteredList = tempFilteredList.where((order) {
//         // Define what fields your search bar should check
//         final name = order.customer!.name.toLowerCase();
//         final phone = order.customer!.phone.toLowerCase();
//         final orderId = order.orderID.toLowerCase(); // Assuming orderID is a string
//
//         return name.contains(query) ||
//             phone.contains(query) ||
//             orderId.contains(query);
//       }).toList();
//     }
//
//     // 3. Apply Sort
//     if (_sortField != null) {
//       tempFilteredList.sort((a, b) {
//         final aValue = _sortField!(a);
//         final bValue = _sortField!(b);
//         return sortAscending
//             ? Comparable.compare(aValue, bValue)
//             : Comparable.compare(bValue, aValue);
//       });
//     }
//
//     // 4. Update the list for the UI
//     _displayOrders = tempFilteredList;
//     notifyListeners();
//   }}