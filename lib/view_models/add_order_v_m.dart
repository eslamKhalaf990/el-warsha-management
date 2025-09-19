import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/models/order_items_model.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/services/orders_service.dart';

class AddOrderVM extends ChangeNotifier {
  final OrdersService _orderService;
  OrderModel orderModel;

  bool isLoading = false;
  String deletedOrder = "";

  Future<List<OrderModel>>? allOrders;

  AddOrderVM(this._orderService, this.orderModel) {
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

  Future<String> deleteOrderByID(String orderID) async {
    String state = "";
    try {
      isLoading = true;
      deletedOrder = orderID;
      notifyListeners();

      final response = await _orderService.deleteOrder(orderID);
      if (response.statusCode == 204) {
        state = "deleted";

      } else {
        state = "not_deleted";
        debugPrint("Failed to delete your order: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error deleting your order: $e");
    } finally {
      isLoading = false;
      deletedOrder = "";
      notifyListeners();
    }
    return state;
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

  void clearOrder() {
    orderModel = OrderModel();
  }

  void loadOrder(OrderModel existingOrder) {
    orderModel = OrderModel.get(
      orderItems: existingOrder.orderItems,
      orderSource: existingOrder.orderSource,
      downPayment: existingOrder.downPayment,
      paymentMethod: existingOrder.paymentMethod,
      delivery: existingOrder.delivery,
      customer: existingOrder.customer,
      discount: existingOrder.discount,
      orderID: existingOrder.orderID,
      totalPrice: existingOrder.totalPrice,
      orderDate: existingOrder.orderDate,
      status: existingOrder.status,
    );
    notifyListeners();
  }

  set addCustomer(CustomerModel value) {
    orderModel.customer = value;
    notifyListeners();
  }

  set addToOrderItems(OrderItemsModel value) {
    orderModel.orderItems.add(value);
    notifyListeners();
  }

  set removeFromOrderItems(String productId) {
    orderModel.orderItems.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  set incrementItemQuantity(int index) {
    orderModel.orderItems[index].quantityToOrder++;
    notifyListeners();
  }

  set decrementItemQuantity(int index) {
    if(orderModel.orderItems[index].quantityToOrder > 1){
      orderModel.orderItems[index].quantityToOrder--;
      notifyListeners();
    }
    else {
      orderModel.orderItems.remove(orderModel.orderItems[index]);
      notifyListeners();
    }
  }

  double getTotalPrice (){
    double itemsTotal = 0.0;

    itemsTotal = orderModel.orderItems.fold(0, (sum, item) {
      final unitPrice = double.tryParse(item.unitPrice) ?? 0;
      return sum + unitPrice * (item.quantityToOrder);
    });

    return itemsTotal;
  }
}
