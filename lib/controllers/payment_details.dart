import 'package:flutter/material.dart';

class PaymentDetails extends ChangeNotifier {
  final TextEditingController downPayment = TextEditingController();
  final TextEditingController paymentMethod = TextEditingController();
  final TextEditingController discount = TextEditingController();
  final TextEditingController platformSource = TextEditingController();
  final TextEditingController delivery = TextEditingController();

  double _basePrice = 0; // Original price (set it when order is created)

  PaymentDetails() {

    // Listen for changes
    downPayment.addListener(_onFieldChanged);
    discount.addListener(_onFieldChanged);
    delivery.addListener(_onFieldChanged);
  }

  double get basePrice => _basePrice;

  set basePrice(double value) {
    _basePrice = value;
    notifyListeners();
  }

  /// Calculate total price
  double get totalPrice {
    final double discountValue = double.tryParse(discount.text) ?? 0;
    final double downPaymentValue = double.tryParse(downPayment.text) ?? 0;
    final double deliveryValue = double.tryParse(delivery.text) ?? 0;

    return (_basePrice - discountValue - downPaymentValue) + deliveryValue;
  }

  void _onFieldChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    downPayment.dispose();
    paymentMethod.dispose();
    discount.dispose();
    platformSource.dispose();
    delivery.dispose();
    super.dispose();
  }
}
