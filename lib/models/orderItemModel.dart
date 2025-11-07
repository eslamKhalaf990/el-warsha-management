class OrderItemModel {
  final int productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  int quantityToOrder = 1;
  int orderedQuantity = 1;


  OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  // Manual fromJson
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final orderItem = OrderItemModel(
      productId: json['productId'] as int? ?? 0,
      productName: json['productName'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      unitPrice: (json['unitPrice'] as num? ?? 0).toDouble(),
    );

    orderItem.orderedQuantity = json['quantity'] ?? "1";
    return orderItem;
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantityToOrder,
      'unitPrice': unitPrice,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'productId': productId,
      'quantity': orderedQuantity,
      'unitPrice': unitPrice,
    };
  }


}