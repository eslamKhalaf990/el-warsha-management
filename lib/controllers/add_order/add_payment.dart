import 'package:flutter/material.dart';
import 'package:warsha_app/models/orderModel.dart';

class PaymentProvider extends ChangeNotifier {
  final TextEditingController downPayment = TextEditingController();
  final TextEditingController paymentMethod = TextEditingController();
  final TextEditingController discount = TextEditingController();
  final TextEditingController platformSource = TextEditingController();
  final TextEditingController delivery = TextEditingController();
  final TextEditingController notes = TextEditingController();

  double _basePrice = 0;

  PaymentProvider() {

    // Listen for changes
    downPayment.addListener(_onFieldChanged);
    discount.addListener(_onFieldChanged);
    delivery.addListener(_onFieldChanged);
    notes.addListener(_onFieldChanged);
  }

  double get basePrice => _basePrice;

  set basePrice(double value) {
    _basePrice = value;
    notifyListeners();
  }

  void loadPayment(OrderModel existingOrder) {
    downPayment.text = existingOrder.downPayment.toString();
    paymentMethod.text = existingOrder.paymentMethod ??"-";
    discount.text ="0.0";
    platformSource.text = existingOrder.orderSource ?? "-";
    delivery.text = existingOrder.delivery.toString();
    notes.text = existingOrder.notes ?? "-";

    // if you want to set base price too, calculate from items
    if (existingOrder.orderItems.isNotEmpty) {
      _basePrice = existingOrder.orderItems.fold(0, (sum, item) {
        final unitPrice = item.unitPrice;
        return sum + unitPrice * item.quantityToOrder;
      });
    }

    notifyListeners();
  }

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
    notes.dispose();
    super.dispose();
  }

  void clearPaymentDetails (){
    downPayment.clear();
    paymentMethod.clear();
    discount.clear();
    platformSource.clear();
    delivery.clear();
    notes.clear();
    _basePrice = 0;
    notifyListeners();
  }
}
