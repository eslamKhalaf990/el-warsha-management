class GovernorateCountPerCustomer {
  final String governorate;
  final int count;

  GovernorateCountPerCustomer({
    required this.governorate,
    required this.count,
  });

  factory GovernorateCountPerCustomer.fromJson(Map<String, dynamic> json) {
    return GovernorateCountPerCustomer(
      governorate: json['governorate'] as String,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'governorate': governorate,
      'count': count,
    };
  }
}