class ProductModel {
  String productName;
  String productDescription;
  String productSPrice;
  String productBPrice;
  String productCategory;
  String productQuantity;
  String? productSKU;

  ProductModel({
    required this.productName,
    required this.productDescription,
    required this.productBPrice,
    required this.productSPrice,
    required this.productCategory,
    required this.productQuantity,
    this.productSKU,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['name'],
      productDescription: json['description'],
      productSPrice: json['sellingPrice'].toString(),
      productBPrice: json['buyingPrice'].toString(),
      productCategory: json['category'],
      productQuantity: json['quantity'],
      productSKU: json['sku'],
    );
  }
  factory ProductModel.toJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['name'],
      productDescription: json['description'],
      productBPrice: json['sellingPrice'].toString(),
      productSPrice: json['BuyingPrice'].toString(),
      productQuantity: json['quantity'],
      productCategory: json['category'],
      productSKU: json['sku'],
    );
  }
}