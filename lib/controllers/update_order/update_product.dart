import 'package:flutter/material.dart';
import 'package:warsha_app/models/product_model.dart';

class UpdateProductProvider extends ChangeNotifier {
  // TextEditingControllers
  final TextEditingController productName = TextEditingController();
  final TextEditingController productDescription = TextEditingController();
  final TextEditingController productBuyingPrice = TextEditingController();
  final TextEditingController productSellingPrice = TextEditingController();
  final TextEditingController productCategory = TextEditingController();
  final TextEditingController productQuantity = TextEditingController();
  final TextEditingController discount = TextEditingController();

  // Live price tracking
  double _buyingPrice = 0.0;
  double _sellingPrice = 0.0;

  double get buyingPrice => _buyingPrice;
  double get sellingPrice => _sellingPrice;
  double get profit => _sellingPrice - _buyingPrice;

  void updateBuyingPrice(String value) {
    _buyingPrice = double.tryParse(value) ?? 0.0;
    notifyListeners();
  }

  void updateSellingPrice(String value) {
    _sellingPrice = double.tryParse(value) ?? 0.0;
    notifyListeners();
  }

  void loadProduct(ProductModel existingProduct) {
    productName.text = existingProduct.name;
    productDescription.text = existingProduct.productDescription;
    productBuyingPrice.text = existingProduct.buyingPrice.toString();
    productSellingPrice.text = existingProduct.sellingPrice.toString();
    productCategory.text = existingProduct.category;
    productQuantity.text = existingProduct.quantity.toString();
    discount.text = existingProduct.discount;

    // Update profit calculation values
    _buyingPrice = double.tryParse(productBuyingPrice.text) ?? 0.0;
    _sellingPrice = double.tryParse(productSellingPrice.text) ?? 0.0;

    notifyListeners();
  }

  // Dispose controllers
  @override
  void dispose() {
    productName.dispose();
    productDescription.dispose();
    productBuyingPrice.dispose();
    productSellingPrice.dispose();
    productCategory.dispose();
    productQuantity.dispose();
    discount.dispose();
    super.dispose();
  }
}
