import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/utils/const_values.dart';

import 'base_url.dart';

class OrdersService {
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
          Baseurl.getAllOrderAPI,
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get your orders: $e');
    }
    return response;
  }

  Future<http.Response> addOrder(OrderModel order, String token) async {
    debugPrint("addOrder called ${order.toJson()}");
    http.Response response;
    try {
      response = await http.post(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Authorization": 'Bearer $token',
          },
          Uri.parse(
            Baseurl.addOrderAPI,
          ),
          body: jsonEncode(order.toJson())
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add your new order: $e');
    }
    return response;
  }

  Future<http.Response> updateOrderStatus(String orderID, String status, String token) async {
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
            "status": status
          })
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add your new order: $e');
    }
    return response;
  }

  Future<http.Response> updateOrder(OrderModel order, String token) async {
    debugPrint("updateOrder called ${order.toJson()}");
    http.Response response;
    try {
      response = await http.put(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Authorization": 'Bearer $token',
          },
          Uri.parse(
            "${Baseurl.addOrderAPI}/${order.orderID}",
          ),
          body: jsonEncode(order.toUpdateJson())
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add your new order: $e');
    }
    return response;
  }

  Future<http.Response> deleteOrder(String order, String token) async {
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


}
