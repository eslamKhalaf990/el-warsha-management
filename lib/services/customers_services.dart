import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/utils/const_values.dart';

import 'base_url.dart';

class CustomerService {
  // This class will handle the logic for attendance management.
  Future<http.Response> getAllCustomers() async {
    debugPrint("getAllCustomers called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        Uri.parse(
          Baseurl.getAllCustomersAPI,
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
      debugPrint(response.body);
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get your requests: $e');
    }
    return response;
  }
  Future<http.Response> addCustomer(CustomerModel customer) async {
    debugPrint("addCustomer called ${customer.name}");
    http.Response response;
    try {
      response = await http.post(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          Uri.parse(
            Baseurl.addCustomerAPI,
          ),
          body: jsonEncode({
            "fullName": customer.name,
            "phone": customer.phone,
            "email": customer.governorate,
            "address": customer.address,
          })
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
      debugPrint(response.body);
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add your new customer: $e');
    }
    return response;
  }

  Future<http.Response> updateCustomer(String id, CustomerModel customer) async {
    debugPrint("updateCustomer with id: $id");
    http.Response response;
    try {
      response = await http.put(
        Uri.parse('${Baseurl.updateCustomerAPI}/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "fullName": customer.name,
          "phone": customer.phone,
          "email": customer.governorate,
          "address": customer.address,
        }),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      debugPrint(response.body);
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to update the customer: $e');
    }
    return response;
  }

}
