class ProductModel {
  String productName;
  String productDescription;
  String productSPrice;
  String productBPrice;
  // String productImage;
  String productCategory;
  String productSKU;
  // String productStatus;

  ProductModel({
    required this.productName,
    required this.productDescription,
    required this.productBPrice,
    required this.productSPrice,
    // required this.productImage,
    required this.productCategory,
    required this.productSKU,
    // required this.productStatus,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['name'],
      productDescription: json['description'],
      productBPrice: json['price'].toString(),
      productSPrice: json['price'].toString(),
      // productImage: json['product_image'],
      productCategory: json['category'],
      productSKU: json['sku'],
    );
  }
}