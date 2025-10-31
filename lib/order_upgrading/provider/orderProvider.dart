import 'package:flutter/foundation.dart';

import '../models/orderModel.dart';
import '../service/orderService.dart' show OrderService;

// The different states our View can be in
enum ViewState { idle, loading, error }

class GetDeleteOrderVM extends ChangeNotifier {
  final OrderService _orderService;

  GetDeleteOrderVM(this._orderService);

  // --- State ---
  ViewState _state = ViewState.idle;
  List<OrderModel> _orders = [];
  String _errorMessage = '';

  // --- Getters ---
  ViewState get state => _state;
  List<OrderModel> get orders => _orders;
  String get errorMessage => _errorMessage;

  // --- Public Methods ---

  Future<void> fetchOrders() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      _orders = await _orderService.fetchOrders();
      _state = ViewState.idle;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    }

    notifyListeners();
  }

  Future<void> deleteOrder(int id) async {
    try {
      await _orderService.deleteOrder(id);
      // If delete is successful, remove from the local list
      _orders.removeWhere((order) => order.orderId == id);
    } catch (e) {
      // In a real app, you'd show a SnackBar with this error
      _errorMessage = e.toString();
      _state = ViewState.error; // You might not want to set a global error here
    }

    notifyListeners();
  }
}