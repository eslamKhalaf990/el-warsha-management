import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/utils/const_values.dart';

import 'base_url.dart';

class ProductService {
  // This class will handle the logic for attendance management.
  Future<http.Response> getAllProducts() async {
    debugPrint("getAllProducts called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        Uri.parse(
          Baseurl.getAllProductsAPI,
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

  Future<http.Response> addProduct(ProductModel product) async {
    debugPrint("addProduct called");
    http.Response response;
    try {
      response = await http.post(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        Uri.parse(
          Baseurl.addProductAPI,
        ),
        body: jsonEncode({
          "description": product.productDescription,
          "name": product.productName,
          "category": product.productCategory,
          "buyingPrice": product.productBPrice,
          "sellingPrice": product.productSPrice,
          "quantity": product.productQuantity,
        })
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
      debugPrint(response.body);
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add your new product: $e');
    }
    return response;
  }
}
