class ProductModel {
  String productName;
  String productDescription;
  String productSPrice;
  String productBPrice;
  String productCategory;
  String productSKU;

  ProductModel({
    required this.productName,
    required this.productDescription,
    required this.productBPrice,
    required this.productSPrice,
    required this.productCategory,
    required this.productSKU,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['name'],
      productDescription: json['description'],
      productBPrice: json['price'].toString(),
      productSPrice: json['price'].toString(),
      productCategory: json['category'],
      productSKU: json['sku'],
    );
  }
  factory ProductModel.toJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['name'],
      productDescription: json['description'],
      productBPrice: json['price'].toString(),
      productSPrice: json['price'].toString(),
      productCategory: json['category'],
      productSKU: json['sku'],
    );
  }
}