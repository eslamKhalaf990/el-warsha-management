class CustomerModel {
  String name;
  late String id;
  String governorate;
  String phone;
  String address;

  CustomerModel.add({
    required this.name,
    required this.governorate,
    required this.phone,
    required this.address,
  });

  CustomerModel.get({
    required this.name,
    required this.id,
    required this.governorate,
    required this.phone,
    required this.address,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel.get(
      name: json['fullName'],
      id: (json['id'] ?? json['customerId']).toString()  ,
      governorate: json['governorate'],
      phone: json['phone'].toString(),
      address: json['address'],
    );
  }

  factory CustomerModel.toJson(Map<String, dynamic> json) {
    return CustomerModel.add(
      name: json['fullName'],
      governorate: json['governorate'],
      phone: json['phone'].toString(),
      address: json['address'],
    );
  }
}