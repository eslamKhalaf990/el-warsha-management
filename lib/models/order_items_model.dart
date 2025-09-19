class OrderItemsModel {
  final String productId;
  final String name;
  final String quantity;
  int quantityToOrder = 1;
  int orderedQuantity = 1;
  final String unitPrice;

  OrderItemsModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
  });

  factory OrderItemsModel.fromJson(Map<String, dynamic> json) {
    final model = OrderItemsModel(
      productId: json['productId'].toString(),
      name: json['productName'].toString(),
      quantity: json['quantity'].toString(),
      unitPrice: json['unitPrice'].toString(),
    );
    model.orderedQuantity = json['quantity'] ?? "1";
    return model;
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
