import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
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

  void clear (){
    productName.clear();
    productName.clear();
    productDescription.clear();
    productBuyingPrice.clear();
    productSellingPrice.clear();
    productCategory.clear();
    productQuantity.clear();
    discount.clear();
  }
}
