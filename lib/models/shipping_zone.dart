class ShippingZone {
  final int? id;
  final String cityName;
  final double shippingPrice;

  ShippingZone({
    this.id,
    required this.cityName,
    required this.shippingPrice,
  });

  factory ShippingZone.fromJson(Map<String, dynamic> json) {
    return ShippingZone(
      id: json['id'] as int?,
      cityName: json['cityName'] as String,
      shippingPrice: (json['shippingFee'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cityName': cityName,
      'shippingFee': shippingPrice,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShippingZone &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
