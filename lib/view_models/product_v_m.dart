import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/services/products_service.dart';

class ProductVM extends ChangeNotifier {
  final ProductService _productService;

  bool isLoading = false;

  ProductVM(this._productService);

  Future<List<ProductModel>> getAllProducts() async {
    List<ProductModel> products = [];
    try {
      isLoading = true;
      final response = await _productService.getAllProducts();
      if (response.statusCode == 200) {
        final productsData = jsonDecode(response.body);
        final List<dynamic> data = productsData;
        products = data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        debugPrint("Failed to fetch products: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return products;
  }
}