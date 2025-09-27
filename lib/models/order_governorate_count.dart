class GovernorateCountPerOrder {
  final String governorate;
  final int count;

  GovernorateCountPerOrder({
    required this.governorate,
    required this.count,
  });

  factory GovernorateCountPerOrder.fromJson(Map<String, dynamic> json) {
    return GovernorateCountPerOrder(
      governorate: json['governorate'] as String,
      count: json['orderCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'governorate': governorate,
      'orderCount': count,
    };
  }
}