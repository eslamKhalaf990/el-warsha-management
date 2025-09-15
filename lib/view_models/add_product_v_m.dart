import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/services/products_service.dart';

class ProductVM extends ChangeNotifier {
  final ProductService _productService;

  bool isLoading = false;
  String deletedProduct = "";


  Future<List<ProductModel>>? allProducts;
  final TextEditingController searchController = TextEditingController();

  ProductVM(this._productService) {
    initAllProducts();
    searchController.addListener(() {
      notifyListeners();
    });
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
    required Uint8List? imageBytes,
  }) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();

      final response = await _productService.addProductWithImage(
        name: productName,
        description: productDescription,
        buyingPrice: productBPrice,
        sellingPrice: productSPrice,
        category: productCategory,
        quantity: productQuantity,
        imageBytes: imageBytes,
      );

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        status = "product_added";
        debugPrint("Product added: $responseBody");
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

  Future<String> deleteProduct(String productId) async {
    String status = "";
    try {
      isLoading = true;
      deletedProduct = productId;

      notifyListeners();

      final response = await _productService.deleteProduct(productId);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 204) {
        status = "product_deleted";
        debugPrint("Product deleted successfully");
      } else {
        status = "product_not_deleted";
        debugPrint("Failed to delete product: ${response.statusCode}");
      }
    } catch (e) {
      status = "product_not_deleted";
      debugPrint("Error deleting product: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return status;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

}
