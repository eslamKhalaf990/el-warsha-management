import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warsha_app/models/create_order_request.dart';
import 'package:warsha_app/models/orderModel.dart';
import 'package:warsha_app/utils/const_values.dart';

import 'base_url.dart';

class OrdersService {

  // In-memory list to simulate a database for deletion
  List<OrderModel>? _cachedOrders;

  // This class will handle the logic for attendance management.
  Future<http.Response> getAllOrders(String token) async {
    debugPrint("getAllOrders called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(
          "${Baseurl.getAllOrderAPI}/by-month?",
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get your orders: $e');
    }
    return response;
  }

  // Update the signature to accept filter and pagination data
  Future<http.Response> getOrdersByMonth(
      String token, {
        required int year,
        required int month,
        int page = 0,
        int size = 20,
      }) async {
    debugPrint("getOrdersByMonth called: $month/$year (Page: $page)");

    http.Response response;

    try {
      final uri = Uri.parse("${Baseurl.getAllOrderAPI}/by-month").replace(queryParameters: {
        'year': year.toString(),
        'month': month.toString(),
        'page': page.toString(),
        'size': size.toString(),
      });

      response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json', // GET usually expects JSON or no content-type
          "Authorization": 'Bearer $token',
        },
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get your orders: $e');
    }

    return response;
  }

  Future<http.Response> updateOrderStatus(String orderID, String status, String token, String bankAccountId) async {
    debugPrint("updateOrderStatus called $status");
    http.Response response;
    try {
      response = await http.put(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Authorization": 'Bearer $token',
          },
          Uri.parse(
            "${Baseurl.addOrderAPI}/status/$orderID",
          ),
          body: jsonEncode({
            "status": status,
            "bankAccountId": bankAccountId,
          })
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add your new order: $e');
    }
    return response;
  }

  Future<http.Response> getGovernorateCounts(String token) async {
    debugPrint("getGovernorateCountsPerOrder called");
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(
          Baseurl.countGovernoratePerOrderAPI,
        ),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token',
        },
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please check your internet connection and try again.');
    } catch (e) {
      throw Exception('Failed to get governorate counts: $e');
    }
    return response;
  }

  Future<List<OrderModel>> fetchOrders(String token, {DateTime? startDate, DateTime? endDate}) async {
    Map<String, String> queryParams = {};

    if (startDate != null) {
      queryParams['startDate'] = startDate.toIso8601String().split('T').first;
    }

    if (endDate != null) {
      queryParams['endDate'] = endDate.toIso8601String().split('T').first;
    }

    final response = await http.get(
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "Authorization":
        'Bearer $token',
      },
      Uri.parse(
        Baseurl.getAllOrderAPI,
      ).replace(queryParameters: queryParams.isNotEmpty ? queryParams : null),
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

  Future<void> addOrder(CreateOrderRequest orderRequest, String token) async {
    print("addOrder ${orderRequest.toJson()}");
    final response = await http
        .post(
      Uri.parse(Baseurl.addOrderAPI),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
      body: jsonEncode(orderRequest.toJson()),
    )
        .timeout(const Duration(seconds: Constants.TIMEOUT));

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Success! Invalidate the cache.
      _cachedOrders = null;
    } else {
      // If the server didn't create the order, throw an error
      throw Exception(
          'Failed to add order: ${response.statusCode} ${response.body}');
    }
  }

  Future<http.Response> updateOrder(OrderModel order, String token) async {
    debugPrint("updateOrder called ${order.toUpdateJson()}");
    http.Response response;
    try {
      response = await http.put(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Authorization": 'Bearer $token',
          },
          Uri.parse(
            "${Baseurl.addOrderAPI}/${order.orderId}",
          ),
          body: jsonEncode(order.toUpdateJson())
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      if (response.statusCode == 200) {
        // Success! Invalidate the cache.
        _cachedOrders = null;
      }

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add your new order: $e');
    }
    return response;
  }

  Future<http.Response> deleteOrder(int order, String token) async {
    debugPrint("deleteOrder called $order");
    http.Response response;
    try {
      response = await http.delete(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(
          "${Baseurl.deleteOrderAPI}/$order",
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to delete your order: $e');
    }
    return response;
  }

  Future<http.Response> cancelOrder(String order, String token) async {
    debugPrint("cancelOrder called $order");
    http.Response response;
    try {
      response = await http.put(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(
          "${Baseurl.cancelOrderAPI}/$order",
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to cancel your order: $e');
    }
    return response;
  }
}
