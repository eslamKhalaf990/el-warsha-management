import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/utils/const_values.dart';

import 'base_url.dart';

class OrdersService {
  // This class will handle the logic for attendance management.
  Future<http.Response> getAllOrders() async {
    debugPrint("getAllOrders called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        Uri.parse(
          Baseurl.getAllOrderAPI,
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
      debugPrint(response.body);
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get your orders: $e');
    }
    return response;
  }
  Future<http.Response> addOrder(OrderModel order) async {
    debugPrint("addOrder called ${order.toJson()}");
    http.Response response;
    try {
      response = await http.post(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          Uri.parse(
            Baseurl.addOrderAPI,
          ),
          body: jsonEncode(order.toJson())
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
      debugPrint(response.body);
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add your new order: $e');
    }
    return response;
  }
}
