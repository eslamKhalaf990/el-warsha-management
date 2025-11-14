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

  TextEditingController customer = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController governorate = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController source = TextEditingController();
  TextEditingController paymentMethod = TextEditingController();

  OrderVM(this._orderService, this._userViewModel);

  // State
  ViewState _state = ViewState.idle;
  bool _isSaving = false;
  String _errorMessage = '';

  // Orders
  List<OrderModel> _orders = [];
  List<OrderModel> _filteredOrders = [];

  // Sorting
  int? sortColumnIndex;
  bool sortAscending = true;

  // Filtering
  final Map<String, String> _filters = {};
  DateTime? _startDate; // ✨ ADDED
  DateTime? _endDate; // ✨ ADDED

  // Getters
  ViewState get state => _state;
  bool get isSaving => _isSaving;
  String get errorMessage => _errorMessage;

  // ✨ MODIFIED getter to check all filter types
  List<OrderModel> get orders =>
      _filteredOrders.isEmpty &&
          _filters.isEmpty &&
          _startDate == null &&
          _endDate == null
          ? _orders
          : _filteredOrders;

  // ✨ ADDED getters for date range
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  // ────────────────────────────
  // FETCH ORDERS
  // ────────────────────────────
  Future<void> fetchOrders() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      _orders = await _orderService.fetchOrders(_userViewModel.token);
      _filteredOrders = List.from(_orders);
      _state = ViewState.idle;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    }

    notifyListeners();
  }

  // ────────────────────────────
  // ADD ORDER
  // ────────────────────────────
  Future<bool> addOrder(CreateOrderRequest orderRequest) async {
    _isSaving = true;
    _errorMessage = '';
    _state = ViewState.idle;
    notifyListeners();

    try {
      await _orderService.addOrder(orderRequest, _userViewModel.token);
      await fetchOrders();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text("Order added successfully"),
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
        ),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text("Couldn't add order successfully"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      _isSaving = false;
      notifyListeners();
      return false;
    }
  }

  // ────────────────────────────
  // UPDATE ORDER
  // ────────────────────────────
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

      final state =
      await _orderService.updateOrder(orderModel, _userViewModel.token);

      if (state.statusCode == 200) {
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

  // ────────────────────────────
  // UPDATE STATUS
  // ────────────────────────────
  Future<String> updateOrderStatus({
    required String orderID,
    required String statusValue,
    required String bankAccountId,
  }) async {
    String status = "";
    try {
      _isSaving = true;
      notifyListeners();

      final response = await _orderService.updateOrderStatus(
          orderID, statusValue, _userViewModel.token, bankAccountId);

      if (response.statusCode == 200 || response.statusCode == 201) {
        status = "status_updated";
        debugPrint("Order status updated: ${response.body}");
      } else {
        status = "status_not_updated";
        debugPrint("Update failed: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      status = "status_not_updated";
      debugPrint("Error updating order status: $e");
    } finally {
      _isSaving = false;
      notifyListeners();
    }

    return status;
  }

  // ────────────────────────────
  // DELETE ORDER
  // ────────────────────────────
  Future<String> deleteOrder(int id) async {
    String state = "";
    _isSaving = true;
    _errorMessage = '';
    notifyListeners();
    try {
      final response = await _orderService.deleteOrder(id, _userViewModel.token);
      if (response.statusCode == 204) {
        state = "deleted";
        _orders.removeWhere((order) => order.orderId == id);
        _filteredOrders.removeWhere((order) => order.orderId == id);

        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text("Order #$id deleted successfully"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        state = "not_deleted";
        debugPrint("Failed to delete order: ${response.statusCode}");
      }
    } catch (e) {
      _errorMessage = e.toString();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text("Order #$id couldn't be deleted. ${e.toString()}"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      _state = ViewState.error;
    } finally {
      _isSaving = false;
      notifyListeners();
    }

    return state;
  }

  // ────────────────────────────
  // SORTING
  // ────────────────────────────
  void sort<T>(
      Comparable<T> Function(OrderModel order) getField,
      int columnIndex,
      bool ascending,
      ) {
    _filteredOrders.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    sortColumnIndex = columnIndex;
    sortAscending = ascending;
    notifyListeners();
  }

  // ────────────────────────────
  // FILTERING
  // ────────────────────────────

  /// ✨ ADDED: Call this from your UI to set the date range
  void setDateRange(DateTimeRange? range) {
    if (range != null) {
      _startDate = range.start;
      _endDate = range.end;
    } else {
      _startDate = null;
      _endDate = null;
    }
    _filterOrders(); // Re-apply all filters
  }

  void applyFilter(String key, String value) {
    if (value.trim().isEmpty) {
      _filters.remove(key);
    } else {
      _filters[key] = value.toLowerCase();
    }
    _filterOrders();
  }

  /// ✨ MODIFIED: Now clears date filters as well
  void clearAllFilters() {
    _filters.clear();
    _startDate = null;
    _endDate = null;
    _filteredOrders = List.from(_orders);
    notifyListeners();
  }

  /// ✨ MODIFIED: Now applies both text and date filters
  void _filterOrders() {
    _filteredOrders = _orders.where((order) {

      // --- 1. Text Filters (Existing Logic) ---
      bool passesTextFilter = true;
      if (_filters.isNotEmpty) {
        for (var entry in _filters.entries) {
          final key = entry.key;
          final query = entry.value;

          String target = '';
          switch (key) {
            case 'status':
              target = order.status?.toLowerCase() ?? '';
              break;
            case 'customer':
              target = order.customer?.fullName.toLowerCase() ?? '';
              break;
            case 'phone':
              target = order.customer?.phone.toLowerCase() ?? '';
              break;
            case 'paymentMethod':
              target = order.paymentMethod?.toLowerCase() ?? '';
              break;
            case 'governorate':
              target = order.customer?.governorate.toLowerCase() ?? '';
              break;
            case 'source':
              target = order.orderSource?.toLowerCase() ?? '';
              break;
            case 'total':
              target = (order.totalPrice ?? 0).toString();
              break;
          }

          if (!target.contains(query)) {
            passesTextFilter = false;
            break; // Stop checking filters if one fails
          }
        }
      }

      if (!passesTextFilter) return false; // Failed text filter

      // --- 2. Date Filters (New Logic) ---
      bool passesDateFilter = true;
      final orderDate = order.orderDate; // Assuming OrderModel has DateTime? orderDate

      if (orderDate != null) {
        // Check Start Date
        if (_startDate != null) {
          // Normalize start date to 00:00:00 to be inclusive
          final normalizedStartDate = DateTime(_startDate!.year, _startDate!.month, _startDate!.day);
          if (orderDate.isBefore(normalizedStartDate)) {
            passesDateFilter = false;
          }
        }

        // Check End Date (if start date check passed)
        if (passesDateFilter && _endDate != null) {
          // Normalize end date to be the *start* of the *next* day
          // This makes the check inclusive for the entire selected end day
          final normalizedEndDate = DateTime(_endDate!.year, _endDate!.month, _endDate!.day + 1);
          if (!orderDate.isBefore(normalizedEndDate)) {
            passesDateFilter = false;
          }
        }
      } else if (_startDate != null || _endDate != null) {
        // If a date filter is set, but the order has no date, exclude it.
        passesDateFilter = false;
      }

      if (!passesDateFilter) return false; // Failed date filter

      // If we get here, it passed both text and date filters
      return true;

    }).toList();

    notifyListeners();
  }
}