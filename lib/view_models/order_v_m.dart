import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/models/order_items_model.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/services/orders_service.dart';

class OrderVM extends ChangeNotifier {
  final OrdersService _orderService;
  OrderModel orderModel;

  bool isLoading = false;

  Future<List<OrderModel>>? allOrders;

  OrderVM(this._orderService, this.orderModel) {
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

  Future<String> addOrder({
    required String customerID,
    required String delivery,
    required String discount,
    required String orderSource,
    required String paymentMethod,
    required String downPayment,
    required List<OrderItemsModel> orderItems,
  }) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();

      OrderModel orderModel = OrderModel.add(customerID: customerID, orderItems: orderItems,
          orderSource: orderSource,
          downPayment: downPayment,
          paymentMethod: paymentMethod,
          delivery: delivery, discount: discount);

      final response = await _orderService.addOrder(orderModel);

      if (response.statusCode == 200 || response.statusCode == 201) {
        status = "order_added";
      } else {
        status = "order_not_added";
      }
    } catch (e) {
      status = "order_not_added";
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return status;
  }

  set addCustomer(CustomerModel value) {
    orderModel.customer = value;
    notifyListeners();
  }

  set addToOrderItems(OrderItemsModel value) {
    orderModel.orderItems.add(value);
    notifyListeners();
  }

  set addItemQuantity(int index) {
    orderModel.orderItems[index].quantityToOrder++;
    notifyListeners();
  }

  double getTotalPrice (){
    double itemsTotal = 0.0;

    for (var item in orderModel.orderItems) {
      itemsTotal += double.parse(item.unitPrice);
    }
    return itemsTotal;
  }

  set removeByProductId(String productId) {
    orderModel.orderItems.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }
}
