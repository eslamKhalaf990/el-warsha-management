import 'dart:convert';

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

  Future<String> addProduct(String productName, String productDescription,
      String productBPrice, String productSPrice, String productCategory, productQuantity) async {
    String status = "";
    try {
      isLoading = true;
      ProductModel product = ProductModel(
        productName: productName,
        productDescription: productDescription,
        productBPrice: productBPrice,
        productSPrice: productSPrice,
        productCategory: productCategory,
        productQuantity: productQuantity,
      );
      final response = await _productService.addProduct(product);
      if (response.statusCode == 201) {
        status = "product_added";
        debugPrint("Product added successfully");
      } else {
        status = "product_not_added";
        debugPrint("Failed to add product: ${response.statusCode}");
      }
    } catch (e) {
      status = "product_not_added";
    debugPrint("Error fetching products: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return status;
  }
}
