import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/services/products_service.dart';

class ProductVM extends ChangeNotifier {
  final ProductService _productService;

  bool isLoading = false;

  Future<List<ProductModel>>? allProducts;

  ProductVM(this._productService) {
    initAllProducts();
  }

  void initAllProducts () {
    allProducts = getAllProducts();
    notifyListeners();
  }

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

  Future<String> addProduct({
    required String productName,
    required String productDescription,
    required String productBPrice,
    required String productSPrice,
    required String productCategory,
    required String productQuantity,
    required File? imageFile,
  }) async {
    String status = "";
    try {
      isLoading = true;

      final response = await _productService.addProductWithImage(
        name: productName,
        description: productDescription,
        buyingPrice: productBPrice,
        sellingPrice: productSPrice,
        category: productCategory,
        quantity: productQuantity,
        imageFile: imageFile,
      );

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        status = "product_added";
        debugPrint("✅ Product added: $responseBody");
      } else {
        status = "product_not_added";
      }
    } catch (e) {
      status = "product_not_added";
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return status;
  }
}
