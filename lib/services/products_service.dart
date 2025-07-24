import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
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

  Future<http.StreamedResponse> addProductWithImage({
    required String name,
    required String description,
    required String buyingPrice,
    required String sellingPrice,
    required String category,
    required String quantity,
    required File? imageFile,
  }) async {
    var uri = Uri.parse(Baseurl.addProductAPI);

    final product = jsonEncode({
      "name": name,
      "description": description,
      "buyingPrice": buyingPrice,
      "sellingPrice": sellingPrice,
      "category": category,
      "quantity": quantity,
    });
    var request = http.MultipartRequest("POST", uri);

    request.fields['product'] = product;

    if (imageFile != null && await imageFile.exists()) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        filename: basename(imageFile.path),
      ));
    }

    return await request.send(); // Let the viewmodel parse the response
  }
}
