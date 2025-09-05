

import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/models/order_items_model.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/services/orders_service.dart';

class UpdateOrderVM extends ChangeNotifier {
  final OrdersService _orderService;
  OrderModel orderModel;

  bool isLoading = false;

  Future<List<OrderModel>>? allOrders;

  UpdateOrderVM(this._orderService, this.orderModel);

  void loadOrder(OrderModel existingOrder) {
    orderModel = OrderModel.get(
      orderItems: List<OrderItemsModel>.from(existingOrder.orderItems),
      orderSource: existingOrder.orderSource,
      downPayment: existingOrder.downPayment,
      paymentMethod: existingOrder.paymentMethod,
      delivery: existingOrder.delivery,
      customer: existingOrder.customer,
      orderID: existingOrder.orderID,
      totalPrice: existingOrder.totalPrice,
      orderDate: existingOrder.orderDate,
      status: existingOrder.status,
    );
    notifyListeners();
  }

  void clearOrder() {
    orderModel = OrderModel();
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
