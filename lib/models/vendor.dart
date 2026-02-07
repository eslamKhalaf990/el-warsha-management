import 'dart:convert';

class Vendor {
  int? vendorId;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? taxNumber;
  String? contactPerson;
  String? notes;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Vendor({
    this.vendorId,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.taxNumber,
    this.contactPerson,
    this.notes,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  // Factory to create a Vendor from JSON map
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorId: json['vendorId'], // Matches Spring Boot field names
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      taxNumber: json['taxNumber'],
      contactPerson: json['contactPerson'],
      notes: json['notes'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // Convert Vendor object to JSON map for API POST/PUT
  Map<String, dynamic> toJson() {
    return {
      'vendorId': vendorId,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'taxNumber': taxNumber,
      'contactPerson': contactPerson,
      'notes': notes,
      'isActive': isActive,
    };
  }

  // Helper to parse a list of vendors from a JSON string
  static List<Vendor> listFromJson(String str) {
    final jsonData = json.decode(str);
    return List<Vendor>.from(jsonData.map((x) => Vendor.fromJson(x)));
  }
}