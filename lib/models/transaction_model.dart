import 'dart:convert';
import 'account_balance.dart';

class Category {
  final int id;
  final String categoryName;
  final String categoryType;

  Category({
    required this.id,
    required this.categoryName,
    required this.categoryType,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['categoryID'] as int,
      categoryName: json['categoryName'] as String,
      categoryType: json['categoryType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
      'categoryType': categoryType,
    };
  }
}


class BankTransaction {
  final int id;
  final BankAccount bankAccount;
  final Category category;
  final String transactionType;
  final double amount;
  final String description;
  final String? referenceType;
  final int? referenceId;
  final DateTime createdAt;

  BankTransaction({
    required this.id,
    required this.bankAccount,
    required this.category,
    required this.transactionType,
    required this.amount,
    required this.description,
    this.referenceType,
    this.referenceId,
    required this.createdAt,
  });

  factory BankTransaction.fromJson(Map<String, dynamic> json) {
    return BankTransaction(
      id: json['id'] as int,
      bankAccount: BankAccount.fromJson(json['bankAccount']),
      category: Category.fromJson(json['category']),
      transactionType: json['transactionType'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      referenceType: json['referenceType'],
      referenceId: json['referenceId'],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  static List<BankTransaction> listFromJson(String jsonStr) {
    final data = jsonDecode(jsonStr) as List;
    return data.map((e) => BankTransaction.fromJson(e)).toList();
  }
}
