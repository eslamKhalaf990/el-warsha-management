class CategoryModel {
  final int categoryId;
  final String name;

  CategoryModel({
    required this.categoryId,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'] as int,
      name: json['name'] as String,
    );
  }
// 1. Override equality operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryModel &&
              runtimeType == other.runtimeType &&
              categoryId == other.categoryId; // Compare by ID

  // 2. Override hashCode
  @override
  int get hashCode => categoryId.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
    };
  }
}
