import 'package:flutter/foundation.dart';
import 'package:warsha_app/order_upgrading/models/create_order_request.dart';

import '../models/orderModel.dart';
import '../service/orderService.dart' show OrderService;

// The different states our View can be in
enum ViewState { idle, loading, error }

class GetDeleteOrderVM extends ChangeNotifier {
  final OrderService _orderService;

  GetDeleteOrderVM(this._orderService);

  // --- State ---
  ViewState _state = ViewState.idle;
  bool _isSaving = false; // --- NEW ---
  List<OrderModel> _orders = [];
  String _errorMessage = '';

  // --- Getters ---
  ViewState get state => _state;
  bool get isSaving => _isSaving; // --- NEW ---
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

  Future<bool> addOrder(CreateOrderRequest orderRequest) async {
    _isSaving = true;
    _errorMessage = '';
    _state = ViewState.idle; // Clear any previous errors
    notifyListeners();

    try {
      // 1. Call the service
      await _orderService.addOrder(orderRequest);

      // 2. On success, set saving to false
      _isSaving = false;

      // 3. Refresh the list from the server (since the cache was invalidated)
      await fetchOrders();
      return true; // Success
    } catch (e) {
      // 4. On failure, set state and return false
      _errorMessage = e.toString();
      _state = ViewState.error;
      _isSaving = false;
      notifyListeners();
      return false; // Failure
    }
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