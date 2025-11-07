import 'package:flutter/material.dart';
import 'package:warsha_app/models/create_order_request.dart';
import 'package:warsha_app/models/orderItemModel.dart';
import 'package:warsha_app/services/orders_service.dart';
import 'package:warsha_app/utils/navigator.dart';
import 'package:warsha_app/view_models/user_v_m.dart';
import '../models/orderModel.dart';

enum ViewState { idle, loading, error }

class OrderVM extends ChangeNotifier {
  final OrdersService _orderService;
  final UserViewModel _userViewModel;

  OrderVM(this._orderService, this._userViewModel);

  // State
  ViewState _state = ViewState.idle;
  bool _isSaving = false;
  List<OrderModel> _orders = [];
  String _errorMessage = '';

  // Getters
  ViewState get state => _state;
  bool get isSaving => _isSaving;
  List<OrderModel> get orders => _orders;
  String get errorMessage => _errorMessage;

  //get all orders
  Future<void> fetchOrders() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      _orders = await _orderService.fetchOrders(_userViewModel.token);
      _state = ViewState.idle;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    }

    notifyListeners();
  }

  //add order
  Future<bool> addOrder(CreateOrderRequest orderRequest) async {
    print(orderRequest.toJson());
    _isSaving = true;
    _errorMessage = '';
    _state = ViewState.idle; // Clear any previous errors
    notifyListeners();

    try {
      // 1. Call the service
      await _orderService.addOrder(orderRequest, _userViewModel.token);

      // 3. Refresh the list from the server (since the cache was invalidated)
      await fetchOrders();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text("Order added successfully"),
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
        ),
      );
      return true; // Success
    } catch (e) {
      // 4. On failure, set state and return false
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text("Couldn't add order successfully"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      _isSaving = false;
      notifyListeners();
      return false; // Failure
    }
  }

  //update order
  Future<String> updateOrder({required String customerID, required String orderID, required String delivery, required String notes, required String discount, required String orderSource, required String paymentMethod, required String downPayment, required List<OrderItemModel> orderItems,}) async {
    String status = "";
    _isSaving = true;
    notifyListeners();

    try {
      final orderModel = OrderModel(
        orderId: int.parse(orderID),
        customerId: customerID,
        orderItems: orderItems,
        orderSource: orderSource,
        downPayment: double.parse(downPayment),
        paymentMethod: paymentMethod,
        delivery: double.parse(delivery),
        discount: double.parse(discount),
        notes: notes,
      );

      final state = await _orderService.updateOrder(orderModel, _userViewModel.token);

      if(state.statusCode == 200) {
        await fetchOrders();
        status = "order_updated";
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text("Order #$orderID updated successfully"),
            backgroundColor: Colors.grey,
            duration: const Duration(seconds: 2),
          ),
        );

      } else {
        status = "order_not_updated";
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text("Couldn't update order #$orderID"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }

    } catch (e) {
      debugPrint("Update order error: $e");
      status = "order_not_updated";
    } finally {
      _isSaving = false;
      notifyListeners();
    }

    return status;
  }

  //delete order
  Future<String> deleteOrder(int id) async {
    String state = "";
    _isSaving = true;
    _errorMessage = '';
    _state = ViewState.idle; // Clear any previous errors
    notifyListeners();
    try {
      final response =  await _orderService.deleteOrder(id, _userViewModel.token);
      if (response.statusCode == 204) {
        state = "deleted";

        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text("Order #$id deleted successfully"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );

        _orders.removeWhere((order) => order.orderId == id);
      } else {
        state = "not_deleted";
        debugPrint("Failed to delete your order: ${response.statusCode}");
      }
    } catch (e) {
      // In a real app, you'd show a SnackBar with this error
      _errorMessage = e.toString();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text("Order #$id couldn't be deleted. ${e.toString()}"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      _state = ViewState.error; // You might not want to set a global error here
    } finally {
      _isSaving = false;
      notifyListeners();
    }

    return state;
  }

}