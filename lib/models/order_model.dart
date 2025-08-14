import 'customer_model.dart';
import 'order_items_model.dart';

class OrderModel {
  //customer info
  String? customerID;
  CustomerModel? customer;

  //order
  late String orderID;
  late String orderDate;
  late String status;

  //items
  late List<OrderItemsModel> orderItems = [];
  OrderModel();

  OrderModel.add({
    required this.customerID,
    required this.orderItems,
  });

  OrderModel.get({
    required this.customer,
    required this.orderID,
    required this.orderDate,
    required this.status,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel.get(
      orderID: json['orderId'].toString(),
      status: json['status'].toString(),
      orderDate: json['orderDate'].toString(),
      customer: CustomerModel.fromJson(json['customer']),
      orderItems: (json['orderItems'] as List)
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
