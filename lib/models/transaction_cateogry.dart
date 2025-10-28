import 'dart:convert';

class TransactionCategory {
  final int categoryID;
  final String categoryName;
  final String categoryType;

  TransactionCategory({
    required this.categoryID,
    required this.categoryName,
    required this.categoryType,
  });

  factory TransactionCategory.fromJson(Map<String, dynamic> json) {
    return TransactionCategory(
      categoryID: json['categoryID'],
      categoryName: json['categoryName'],
      categoryType: json['categoryType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryID': categoryID,
      'categoryName': categoryName,
      'categoryType': categoryType,
    };
  }

  static List<TransactionCategory> listFromJson(String jsonStr) {
    final data = json.decode(jsonStr) as List;
    return data.map((item) => TransactionCategory.fromJson(item)).toList();
  }
}
