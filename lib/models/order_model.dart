import 'order_items_model.dart';

class OrderModel {
  final String customerID;
  final List<OrderItemsModel> orderItems;

  OrderModel.add({
    required this.customerID,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel.add(
      customerID: json['customerId'],
      orderItems: (json['items'] as List)
          .map((item) => OrderItemsModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerID,
      'items': orderItems.map((item) => item.toJson()).toList(),
    };
  }
}
