class BankAccount {
  final int id;
  final String name;
  final String accountType;
  final double currentBalance;
  final DateTime createdAt;

  BankAccount({
    required this.id,
    required this.name,
    required this.accountType,
    required this.currentBalance,
    required this.createdAt,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      id: json['id'] as int,
      name: json['name'] as String,
      accountType: json['accountType'] as String,
      currentBalance: (json['currentBalance'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
