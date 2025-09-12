import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/services/products_service.dart';

class UpdateProductVM extends ChangeNotifier {
  final ProductService _productService;
  ProductModel? productModel;

  bool isLoading = false;

  UpdateProductVM(this._productService);

  Future<String> updateProduct({
    required String id,
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

      final response = await _productService.updateProductWithImage(
        id: id,
        name: productName,
        description: productDescription,
        buyingPrice: productBPrice,
        sellingPrice: productSPrice,
        category: productCategory,
        quantity: productQuantity,
        imageBytes: imageBytes,
      );

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        status = "product_updated";
        debugPrint("Product updated: $responseBody");
      } else {
        status = "product_not_updated";
        debugPrint("Update failed: ${response.statusCode} - $responseBody");
      }
    } catch (e) {
      status = "product_not_updated";
      debugPrint("Error updating product: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return status;
  }

  void loadProduct(ProductModel existingProduct) {
    productModel = ProductModel.get(
      id: existingProduct.id,
      name: existingProduct.name,
      buyingPrice: existingProduct.buyingPrice,
      sellingPrice: existingProduct.sellingPrice,
      category: existingProduct.category,
      quantity: existingProduct.quantity,
      productDescription: existingProduct.productDescription,
      image: existingProduct.image,
    );
    notifyListeners();
  }

}
