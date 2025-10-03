import 'customer_model.dart';
import 'order_items_model.dart';

class OrderModel {
  //customer info
  String? customerID;
  CustomerModel? customer;

  //order
  late String orderID;
  late String delivery;
  late String notes;
  late String totalPrice;
  late String discount;
  late String orderSource;
  late String paymentMethod;
  late String downPayment;
  late String orderDate;
  late String status;

  //items
  late List<OrderItemsModel> orderItems = [];
  OrderModel();

  OrderModel.add({
    required this.customerID,
    required this.delivery,
    required this.orderSource,
    required this.notes,
    required this.paymentMethod,
    required this.downPayment,
    required this.discount,
    required this.orderItems,
  });

  OrderModel.get({
    required this.customer,
    required this.orderID,
    required this.orderSource,
    required this.paymentMethod,
    required this.totalPrice,
    required this.delivery,
    required this.downPayment,
    required this.notes,
    required this.orderDate,
    required this.discount,
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
      orderSource: json['orderSource'].toString(),
      paymentMethod: json['paymentMethod'].toString(),
      delivery: json['delivery'].toString(),
      discount: json['discount'].toString(),
      notes: json['notes'].toString() ,
      downPayment: json['downPayment'].toString(),
      totalPrice: json['totalPrice'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerID,
      'downPayment' : downPayment,
      'delivery' : delivery,
      'notes' : notes,
      'orderSource' : orderSource,
      'paymentMethod' : paymentMethod,
      'discount' : discount,
      'items': orderItems.map((item) => item.toJson()).toList(),
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'customerId': customerID,
      'downPayment' : downPayment,
      'notes' : notes,
      'delivery' : delivery,
      'orderSource' : orderSource,
      'paymentMethod' : paymentMethod,
      'discount' : discount,
      'items': orderItems.map((item) => item.toUpdateJson()).toList(),
    };
  }
}
