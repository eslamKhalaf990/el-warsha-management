class CustomerModel {
  String name;
  late String id;
  String email;
  String phone;
  String address;

  CustomerModel.add({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  CustomerModel.get({
    required this.name,
    required this.id,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel.get(
      name: json['fullName'],
      id: (json['customerID'] ?? json['customerId']).toString()  ,
      email: json['email'],
      phone: json['phone'].toString(),
      address: json['address'],
    );
  }

  factory CustomerModel.toJson(Map<String, dynamic> json) {
    return CustomerModel.add(
      name: json['fullName'],
      email: json['email'],
      phone: json['phone'].toString(),
      address: json['address'],
    );
  }
}