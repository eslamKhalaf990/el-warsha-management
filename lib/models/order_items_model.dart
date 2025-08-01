class OrderItemsModel {
  final int productId;
  final int quantity;
  final int unitPrice;

  OrderItemsModel({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
  });

  factory OrderItemsModel.fromJson(Map<String, dynamic> json) {
    return OrderItemsModel(
      productId: json['productId'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }
}
