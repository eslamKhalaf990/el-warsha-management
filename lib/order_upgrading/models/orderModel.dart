import 'customerModel.dart';
import 'orderItemModel.dart';

class OrderModel {
  final int orderId;
  final String status;
  final double discount;
  final double delivery;
  final String notes;
  final double totalPrice;
  final double downPayment;
  final String orderSource;
  final String paymentMethod;
  final DateTime orderDate;
  final CustomerModel customer;
  final List<OrderItemModel> orderItems;

  OrderModel({
    required this.orderId,
    required this.status,
    required this.discount,
    required this.delivery,
    required this.notes,
    required this.totalPrice,
    required this.downPayment,
    required this.orderSource,
    required this.paymentMethod,
    required this.orderDate,
    required this.customer,
    required this.orderItems,
  });

  // Manual fromJson
  factory OrderModel.fromJson(Map<String, dynamic> json) {

    // 1. Safely parse the list of order items
    var itemsList = json['orderItems'] as List? ?? []; // Default to empty list if null
    List<OrderItemModel> items = itemsList
        .map((itemJson) => OrderItemModel.fromJson(itemJson))
        .toList();

    // 2. Return the model with default values for any null fields
    return OrderModel(
      orderId: json['orderId'] as int? ?? 0,
      status: json['status'] as String? ?? '',
      discount: (json['discount'] as num? ?? 0).toDouble(),
      delivery: (json['delivery'] as num? ?? 0).toDouble(),
      notes: json['notes'] as String? ?? '',
      totalPrice: (json['totalPrice'] as num? ?? 0).toDouble(),
      downPayment: (json['downPayment'] as num? ?? 0).toDouble(),
      orderSource: json['orderSource'] as String? ?? '',
      paymentMethod: json['paymentMethod'] as String? ?? '',
      orderDate: DateTime.tryParse(json['orderDate'] as String? ?? '') ?? DateTime.now(),
      customer: CustomerModel.fromJson(json['customer'] as Map<String, dynamic>? ?? {}),
      orderItems: items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customer.customerId,
      'downPayment' : downPayment,
      'delivery' : delivery,
      'notes' : notes,
      'orderSource' : orderSource,
      'paymentMethod' : paymentMethod,
      'discount' : discount,
      'items': orderItems.map((item) => item.toJson()).toList(),
    };
  }
}