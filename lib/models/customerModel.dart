class CustomerModel {
  final int customerId;
  final String fullName;
  final String governorate;
  final String city;
  final String secondaryPhone;
  final String phone;
  final String address;

  CustomerModel({
    required this.customerId,
    required this.fullName,
    required this.governorate,
    required this.secondaryPhone,
    required this.city,
    required this.phone,
    required this.address,
  });

  // Manual fromJson
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerId: json['customerId'] ?? json['id'],
      fullName: json['fullName'] as String? ?? '',
      governorate: json['governorate'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
      secondaryPhone: json['secondaryPhone'] as String? ?? '',
      city: json['city'] as String? ?? '',
    );
  }
}