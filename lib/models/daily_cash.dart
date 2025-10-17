class DailyCashFlowModel {
  final String day;
  final int totalOrders;
  final double dailyCashReceived;
  final double dailyShippedValue;
  final double dailyDeliveryCharges;

  DailyCashFlowModel({
    required this.day,
    required this.totalOrders,
    required this.dailyCashReceived,
    required this.dailyShippedValue,
    required this.dailyDeliveryCharges,
  });

  factory DailyCashFlowModel.fromJson(Map<String, dynamic> json) {
    return DailyCashFlowModel(
      day: json['day'] ?? '',
      totalOrders: json['totalOrders'] ?? 0,
      dailyCashReceived: (json['dailyCashReceived'] ?? 0).toDouble(),
      dailyShippedValue: (json['dailyShippedValue'] ?? 0).toDouble(),
      dailyDeliveryCharges: (json['dailyDeliveryCharges'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'totalOrders': totalOrders,
      'dailyCashReceived': dailyCashReceived,
      'dailyShippedValue': dailyShippedValue,
      'dailyDeliveryCharges': dailyDeliveryCharges,
    };
  }
}
