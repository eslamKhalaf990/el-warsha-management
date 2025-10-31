import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:warsha_app/services/base_url.dart';
import 'package:warsha_app/utils/const_values.dart';

import '../models/orderModel.dart';

class OrderService {
  // In-memory list to simulate a database for deletion
  List<OrderModel>? _cachedOrders;

  Future<List<OrderModel>> fetchOrders() async {
    // Simulate network delay
    final response = await http.get(
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "Authorization": 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuYXNzZXIiLCJpYXQiOjE3NjE5MjY5ODMsImV4cCI6MTc2MTk1NTc4M30.t-2xrBctI-8x1hFsxdGrUq4SQI7xUpo1ahfFbNSnHSg',
      },
      Uri.parse(
        Baseurl.getAllOrderAPI,
      ),
    ).timeout(const Duration(seconds: Constants.TIMEOUT));

    // Parse the JSON data
    try {
      if (_cachedOrders == null) {

        final List<dynamic> jsonList = json.decode(response.body);
        _cachedOrders =
            jsonList.map((json) => OrderModel.fromJson(json)).toList();
      }
      // Return a copy of the list
      return List.from(_cachedOrders!);
    } catch (e) {
      // Throw an exception if parsing fails
      throw Exception('Failed to load orders: ${e.toString()}');
    }
  }

  Future<void> deleteOrder(int id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (_cachedOrders != null) {
      _cachedOrders!.removeWhere((order) => order.orderId == id);
    } else {
      throw Exception('Order list not loaded.');
    }
  }
}