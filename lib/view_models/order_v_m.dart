import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/order_items_model.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/services/orders_service.dart';
import 'package:warsha_app/services/products_service.dart';

class OrderVM extends ChangeNotifier {
  final OrdersService _orderService;

  bool isLoading = false;

  Future<List<OrderModel>>? allOrders;

  OrderVM(this._orderService) {
    initAllOrders();
  }

  void initAllOrders () {
    allOrders = getAllOrders();
    notifyListeners();
  }

  Future<List<OrderModel>> getAllOrders() async {
    List<OrderModel> orders = [];
    try {
      isLoading = true;
      final response = await _orderService.getAllOrders();
      if (response.statusCode == 200) {
        final ordersData = jsonDecode(response.body);
        final List<dynamic> data = ordersData;
        orders = data.map((item) => OrderModel.fromJson(item)).toList();
      } else {
        debugPrint("Failed to fetch orders: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching orders: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return orders;
  }

  Future<String> addProduct({
    required String customerID,
    required List<OrderItemsModel> orderItems,
  }) async {
    String status = "";
    try {
      isLoading = true;
      OrderModel orderModel = OrderModel.add(customerID: customerID, orderItems: orderItems);

      final response = await _orderService.addOrder(orderModel);

      final responseBody = response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        status = "order_added";
        debugPrint("Order added: $responseBody");
      } else {
        status = "order_not_added";
      }
    } catch (e) {
      status = "order_not_added";
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return status;
  }
}
