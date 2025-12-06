class TopProduct {
  final int productId;
  final String name;
  final int totalSold;
  final int totalProfit;

  TopProduct({
    required this.productId,
    required this.name,
    required this.totalSold,
    required this.totalProfit,
  });

  // Factory method to create an instance from a Map (JSON object)
  factory TopProduct.fromJson(Map<String, dynamic> json) {
    return TopProduct(
      // Handling potential type mismatches safely
      productId: json['productId'] as int,
      name: json['name'] as String,
      totalSold: json['totalSold'] as int,
      totalProfit: json['totalProfit'] as int,
    );
  }

  // Method to convert an instance back to JSON (optional but useful)
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'totalSold': totalSold,
    };
  }
}