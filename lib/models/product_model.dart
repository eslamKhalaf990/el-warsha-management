class ProductModel {
  String name;
  late String id;
  String productDescription;
  String sellingPrice;
  String buyingPrice;
  String discount;
  String totalPrice;
  String category;
  String categoryId;
  String quantity;
  String image;
  String? sku;

  ProductModel.add({
    required this.name,
    required this.productDescription,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.discount,
    required this.totalPrice,
    required this.category,
    required this.quantity,
    required this.categoryId,
    required this.image,
    this.sku,
  });

  ProductModel.get({
    required this.name,
    required this.id,
    required this.productDescription,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.discount,
    required this.totalPrice,
    required this.category,
    required this.categoryId,
    required this.quantity,
    required this.image,
    this.sku,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel.get(
      name: json['name'],
      id: json['id'].toString(),
      productDescription: json['description'],
      sellingPrice: json['sellingPrice'].toString(),
      buyingPrice: json['buyingPrice'].toString(),
      discount: json['discount'].toString(),
      totalPrice: json['totalPrice'].toString(),
      category: json['categoryName'],
      categoryId: json['categoryId'].toString(),
      quantity: json['quantity'],
      sku: json['sku'], image: json['imageUrl'] ?? "-",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'productDescription': productDescription,
      'buyingPrice': buyingPrice.toString(),
      'sellingPrice': sellingPrice.toString(),
      'quantity': quantity,
      'categoryName': category,
      'categoryId': categoryId,
      'sku': sku,
    };
  }


    factory ProductModel.toJson(Map<String, dynamic> json) {
    return ProductModel.add(
      name: json['name'],
      productDescription: json['description'],
      buyingPrice: json['sellingPrice'].toString(),
      sellingPrice: json['BuyingPrice'].toString(),
      discount: json['discount'].toString(),
      totalPrice: json['totalPrice'].toString(),
      quantity: json['quantity'],
      category: json['category'],
      categoryId: json['categoryId'],
      sku: json['sku'], image: json['imageUrl']??"-",
    );
  }
}