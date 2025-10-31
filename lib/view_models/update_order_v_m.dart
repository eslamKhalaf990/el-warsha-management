import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/models/order_items_model.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/order_upgrading/models/orderItemModel.dart';
import 'package:warsha_app/order_upgrading/models/orderModel.dart';
import 'package:warsha_app/services/orders_service.dart';
import 'package:warsha_app/view_models/user_v_m.dart';

class UpdateOrderVM extends ChangeNotifier {
  final OrdersService _orderService;
  // OrderModel orderModel;
  final UserViewModel _userViewModel;

  bool isLoading = false;

  Future<List<OrderModel>>? allOrders;

  UpdateOrderVM(this._orderService, this._userViewModel);

  Future<String> updateOrder({
    required String customerID,
    required String orderID,
    required String delivery,
    required String notes,
    required String discount,
    required String orderSource,
    required String paymentMethod,
    required String downPayment,
    required List<OrderItemModel> orderItems,
  }) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();

      // OrderModel orderModel = OrderModel.add(
      //     customerID: customerID,
      //     orderItems: orderItems,
      //     orderSource: orderSource,
      //     downPayment: downPayment,
      //     paymentMethod: paymentMethod,
      //     delivery: delivery,
      //     discount: discount, notes: notes,
      // );
      // orderModel.orderID = orderID;

      // final response = await _orderService.updateOrder(orderModel, _userViewModel.token);
      //
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   status = "order_added";
      // } else {
      //   status = "order_not_added";
      // }
    } catch (e) {
      status = "order_not_added";
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return status;
  }

  Future<String> updateOrderStatus({
    required String orderID,
    required String statusValue,
  }) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();

      final response = await _orderService.updateOrderStatus(
        orderID,
        statusValue,
          _userViewModel.token
      );

      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        status = "status_updated";
        debugPrint("Order status updated: ${response.body}");
      } else {
        status = "status_not_updated";
        debugPrint(
            "Update failed: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      status = "status_not_updated";
      debugPrint("Error updating order status: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return status;
  }


  void loadOrder(OrderModel existingOrder) {
    // orderModel = OrderModel.get(
    //   orderItems: List<OrderItemsModel>.from(existingOrder.orderItems),
    //   orderSource: existingOrder.orderSource,
    //   downPayment: existingOrder.downPayment,
    //   paymentMethod: existingOrder.paymentMethod,
    //   delivery: existingOrder.delivery,
    //   customer: existingOrder.customer,
    //   orderID: existingOrder.orderID,
    //   discount: existingOrder.discount,
    //   totalPrice: existingOrder.totalPrice,
    //   orderDate: existingOrder.orderDate,
    //   status: existingOrder.status,
    //   notes: existingOrder.notes,
    // );
    // notifyListeners();
  }

  void clearOrder() {
    // orderModel = OrderModel();
  }

  set addCustomer(CustomerModel value) {
    // orderModel.customer = value;
    notifyListeners();
  }

  set addToOrderItems(OrderItemsModel value) {
    // orderModel.orderItems.add(value);
    notifyListeners();
  }

  set removeFromOrderItems(String productId) {
    // orderModel.orderItems.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  set incrementItemQuantity(int index) {
    // orderModel.orderItems[index].quantityToOrder++;
    notifyListeners();
  }

  set decrementItemQuantity(int index) {
    // if(orderModel.orderItems[index].quantityToOrder > 1){
    //   orderModel.orderItems[index].quantityToOrder--;
    //   notifyListeners();
    // }
    // else {
    //   orderModel.orderItems.remove(orderModel.orderItems[index]);
    //   notifyListeners();
    // }
  }

  set incrementItemOrdered(int index) {
    // orderModel.orderItems[index].orderedQuantity++;
    notifyListeners();
  }

  set decrementItemOrdered(int index) {
    // if(orderModel.orderItems[index].orderedQuantity > 1){
    //   orderModel.orderItems[index].orderedQuantity--;
    //   notifyListeners();
    // }
    // else {
    //   orderModel.orderItems.remove(orderModel.orderItems[index]);
    //   notifyListeners();
    // }
  }

  double getTotalPrice (){
    double itemsTotal = 0.0;

    // itemsTotal = orderModel.orderItems.fold(0, (sum, item) {
    //   final unitPrice = double.tryParse(item.unitPrice) ?? 0;
    //   return sum + unitPrice * (item.orderedQuantity);
    // });

    return itemsTotal;
  }
}
