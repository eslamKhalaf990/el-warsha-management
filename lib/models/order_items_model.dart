class OrderItemsModel {
  final String productId;
  final String productName;
  final String quantity;
  final String unitPrice;

  OrderItemsModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  factory OrderItemsModel.fromJson(Map<String, dynamic> json) {
    return OrderItemsModel(
      productId: json['productId'].toString(),
      productName: json['productName'].toString(),
      quantity: json['quantity'].toString(),
      unitPrice: json['unitPrice'].toString(),
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
