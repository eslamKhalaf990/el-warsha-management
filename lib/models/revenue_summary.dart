class RevenueSummary {
  final double actualCashReceived;
  final double expectedCash;
  final double potentialRevenue;

  RevenueSummary({
    required this.actualCashReceived,
    required this.expectedCash,
    required this.potentialRevenue,
  });

  factory RevenueSummary.fromJson(Map<String, dynamic> json) {
    return RevenueSummary(
      actualCashReceived: (json['actualCashReceived'] ?? 0).toDouble(),
      expectedCash: (json['expectedCash'] ?? 0).toDouble(),
      potentialRevenue: (json['potentialRevenue'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actualCashReceived': actualCashReceived,
      'expectedCash': expectedCash,
      'potentialRevenue': potentialRevenue,
    };
  }
}
