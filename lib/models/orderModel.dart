import 'customerModel.dart';
import 'orderItemModel.dart';

class OrderModel {
  final int? orderId; // CHANGED: Now nullable
  String? status; // CHANGED: Now nullable
  final String? customerId;
  final double discount;
  final double delivery;
  final String? notes; // CHANGED: Now nullable
  final double? totalPrice; // CHANGED: Now nullable
  final double? downPayment; // CHANGED: Now nullable
  final String? orderSource; // CHANGED: Now nullable
  final String? paymentMethod; // CHANGED: Now nullable
  final DateTime? orderDate; // CHANGED: Now nullable
  final CustomerModel? customer; // CHANGED: Now nullable
  final List<OrderItemModel> orderItems;

  // CHANGED: Constructor now uses default values and doesn't require all fields
  OrderModel({
    this.customerId,
    this.orderId,
    this.status,
    this.discount = 0.0,
    this.delivery = 0.0,
    this.notes,
    this.totalPrice,
    this.downPayment,
    this.orderSource,
    this.paymentMethod,
    this.orderDate,
    this.customer,
    required this.orderItems, // Only 'orderItems' is truly required
  });

  OrderModel copyWith({
    CustomerModel? customer,
    List<OrderItemModel>? orderItems,
    double? discount,
    double? delivery,
    String? notes,
    double? totalPrice,
    double? downPayment,
    String? orderSource,
    String? paymentMethod,
    DateTime? orderDate,
    int? orderId,
    String? status,
  }) {
    return OrderModel(
      customer: customer ?? this.customer,
      orderItems: orderItems ?? this.orderItems,
      discount: discount ?? this.discount,
      delivery: delivery ?? this.delivery,
      notes: notes ?? this.notes,
      totalPrice: totalPrice ?? this.totalPrice,
      downPayment: downPayment ?? this.downPayment,
      orderSource: orderSource ?? this.orderSource,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      orderDate: orderDate ?? this.orderDate,
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
    );
  }

  // Your fromJson is already excellent and safe! No changes needed.
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var itemsList = json['orderItems'] as List? ?? [];
    List<OrderItemModel> items =
        itemsList.map((itemJson) => OrderItemModel.fromJson(itemJson)).toList();

    return OrderModel(
      orderId: json['orderId'] as int?, // Now nullable
      status: json['status'] as String?, // Now nullable
      discount: (json['discount'] as num? ?? 0).toDouble(),
      delivery: (json['delivery'] as num? ?? 0).toDouble(),
      notes: json['notes'] as String?, // Now nullable
      totalPrice: (json['totalPrice'] as num?)?.toDouble(), // Now nullable
      downPayment: (json['downPayment'] as num?)?.toDouble(), // Now nullable
      orderSource: json['orderSource'] as String?, // Now nullable
      paymentMethod: json['paymentMethod'] as String?, // Now nullable
      orderDate:
          DateTime.tryParse(json['orderDate'] as String? ?? ''), // Now nullable
      customer: json['customer'] == null
          ? null // Now nullable
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      orderItems: items,
    );
  }

  // Your toJson is also perfect for creating a new order. No changes needed.
  Map<String, dynamic> toJson() {
    return {
      'customerId': customer?.customerId, // Use safe operator
      'downPayment': downPayment,
      'delivery': delivery,
      'notes': notes,
      'orderSource': orderSource,
      'paymentMethod': paymentMethod,
      'discount': discount,
      'items': orderItems.map((item) => item.toJson()).toList(),
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'customerId': customerId,
      'downPayment': downPayment,
      'notes': notes,
      'delivery': delivery,
      'orderSource': orderSource,
      'paymentMethod': paymentMethod,
      'discount': discount,
      'items': orderItems.map((item) => item.toUpdateJson()).toList(),
    };
  }
}
