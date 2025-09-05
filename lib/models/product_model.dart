class ProductModel {
  String name;
  late String productID;
  String productDescription;
  String sellingPrice;
  String buyingPrice;
  String category;
  String quantity;
  String image;
  String? sku;

  ProductModel.add({
    required this.name,
    required this.productDescription,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.category,
    required this.quantity,
    required this.image,
    this.sku,
  });

  ProductModel.get({
    required this.name,
    required this.productID,
    required this.productDescription,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.category,
    required this.quantity,
    required this.image,
    this.sku,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel.get(
      name: json['name'],
      productID: json['productID'].toString(),
      productDescription: json['description'],
      sellingPrice: json['sellingPrice'].toString(),
      buyingPrice: json['buyingPrice'].toString(),
      category: json['category'],
      quantity: json['quantity'],
      sku: json['sku'], image: json['imageUrl'] ?? "-",
    );
  }
  factory ProductModel.toJson(Map<String, dynamic> json) {
    return ProductModel.add(
      name: json['name'],
      productDescription: json['description'],
      buyingPrice: json['sellingPrice'].toString(),
      sellingPrice: json['BuyingPrice'].toString(),
      quantity: json['quantity'],
      category: json['category'],
      sku: json['sku'], image: json['imageUrl']??"-",
    );
  }
}