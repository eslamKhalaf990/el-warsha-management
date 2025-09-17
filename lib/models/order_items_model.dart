class OrderItemsModel {
  final String productId;
  final String name;
  final String quantity;
  int quantityToOrder = 1;
  int quantityOrdered = 1;
  final String unitPrice;

  OrderItemsModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
  });

  factory OrderItemsModel.fromJson(Map<String, dynamic> json) {
    return OrderItemsModel(
      productId: json['productId'].toString(),
      name: json['productName'].toString(),
      quantity: json['quantity'].toString(),
      unitPrice: json['unitPrice'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantityToOrder,
      'unitPrice': unitPrice,
    };
  }
}
