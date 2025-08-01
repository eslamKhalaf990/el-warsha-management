class CustomerModel {
  String customerName;
  late String customerID;
  String email;
  String phone;
  String address;

  CustomerModel.add({
    required this.customerName,
    required this.email,
    required this.phone,
    required this.address,
  });

  CustomerModel.get({
    required this.customerName,
    required this.customerID,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel.get(
      customerName: json['fullName'],
      customerID: json['customerID'].toString(),
      email: json['email'],
      phone: json['phone'].toString(),
      address: json['address'],
    );
  }

  factory CustomerModel.toJson(Map<String, dynamic> json) {
    return CustomerModel.add(
      customerName: json['fullName'],
      email: json['email'],
      phone: json['phone'].toString(),
      address: json['address'],
    );
  }
}