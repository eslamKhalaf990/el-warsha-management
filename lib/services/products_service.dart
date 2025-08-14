import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
    required Uint8List? imageBytes, // changed type
    String? imageName, // optional, for proper filename
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

    if (imageBytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes as List<int>,
          filename: imageName ?? "upload.jpg",
        ),
      );
    }

    return await request.send();
  }

}
