class CreateOrderItem {
  final int productId;
  final int quantity;
  final double unitPrice;

  CreateOrderItem({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId.toString(),
      'quantity': quantity.toString(),
      'unitPrice': unitPrice.toString(),
    };
  }
}

// This is the main request model
class CreateOrderRequest {
  final int customerId;
  final double delivery;
  final double discount;
  final String downPayment;
  final String bankAccountId;
  final String orderSource;
  final String notes;
  final String paymentMethod;
  final List<CreateOrderItem> items;

  CreateOrderRequest({
    required this.customerId,
    required this.delivery,
    required this.discount,
    required this.downPayment,
    required this.bankAccountId,
    required this.notes,
    required this.orderSource,
    required this.paymentMethod,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'downPayment' : downPayment,
      'bankAccountId' : bankAccountId,
      'delivery' : delivery,
      'notes' : notes,
      'orderSource' : orderSource,
      'paymentMethod' : paymentMethod,
      'discount' : discount,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}