import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/account_balance.dart';
import 'package:warsha_app/models/transaction_add_model.dart';
import 'package:warsha_app/models/transaction_cateogry.dart';
import 'package:warsha_app/models/transaction_model.dart';
import 'package:warsha_app/services/accounting_service.dart';
import 'package:warsha_app/view_models/user_v_m.dart';

class AccountingVM extends ChangeNotifier {
  final AccountingService _accountingService;
  final UserViewModel _userViewModel;

  List<BankAccount>? accountsBalance;
  List<BankTransaction>? allTransactions;
  List<TransactionCategory>? allTransactionCategories;

  AccountingVM(this._accountingService, this._userViewModel) {
    initAccounting();
  }

  void initAccounting () async {
    await getTransactions();
    await getAccountsBalance();
    await getTransactionCategories();
  }

  Future<String> getAccountsBalance({String? password}) async {
    String status = "";
    try {
      final response = await _accountingService.getAccountsBalance(_userViewModel.token, password: password);

      if (response.statusCode == 200) {

        status = "balance_fetched";

        final data = jsonDecode(response.body) as List;

        accountsBalance = data.map((item) => BankAccount.fromJson(item)).toList();
        debugPrint("balance fetched successfully");
      } else {

        status = "balance_not_fetched";
        debugPrint("Failed to fetch balance: ${response.statusCode}");
      }

    } catch (e) {
      status = "balance_not_fetched";
      debugPrint("Error fetching balance: $e");
    } finally {
      notifyListeners();
    }
    return status;
  }

  Future<String> deleteAllTransactions() async {
    String status = "";
    try {
      final response = await _accountingService.deleteAllTransactions(_userViewModel.token);

      if (response.statusCode == 200) {

        status = "transactions_deleted";

        debugPrint("transactions deleted successfully");
      } else {

        status = "transactions_not_deleted";
        debugPrint("Failed to delete transactions: ${response.statusCode}");
      }

    } catch (e) {
      status = "transactions_not_deleted";
      debugPrint("Error deleting transactions: $e");
    } finally {
      notifyListeners();
    }
    return status;
  }

  Future<String> getTransactions() async {
    String status = "";
    try {
      final response = await _accountingService.getTransactions(_userViewModel.token);

      if (response.statusCode == 200) {

        status = "transactions_fetched";

        allTransactions = BankTransaction.listFromJson(response.body);
        debugPrint("balance fetched successfully");
      } else {

        status = "transactions_not_fetched";
        debugPrint("Failed to fetch transactions: ${response.statusCode}");
      }

    } catch (e) {
      status = "transactions_not_fetched";
      debugPrint("Error fetching transactions: $e");
    } finally {
      notifyListeners();
    }
    return status;
  }

  Future<String> addTransaction(TransactionModel transaction) async {
    String status = "";
    try {
      final response = await _accountingService.addTransaction(
        _userViewModel.token,
        transaction,
      );

      if (response.statusCode == 200) {
        debugPrint("Transaction added successfully");

        initAccounting();

        status = "transaction_added";
      } else {
        debugPrint("Failed to add transaction: ${response.statusCode}");
        status = "transaction_not_added";
      }
    } catch (e) {
      debugPrint("Error adding transaction: $e");
      status = "transaction_not_added";
    } finally {
      notifyListeners();
    }
    return status;
  }

  Future<String> getTransactionCategories() async {
    String status = "";
    try {
      final response = await _accountingService.getTransactionCategories(_userViewModel.token);

      if (response.statusCode == 200) {

        status = "categories_fetched";

        allTransactionCategories = TransactionCategory.listFromJson(response.body);
        debugPrint("balance fetched successfully");
      } else {

        status = "categories_not_fetched";
        debugPrint("Failed to fetch transactions categories: ${response.statusCode}");
      }

    } catch (e) {
      status = "categories_not_fetched";
      debugPrint("Error fetching transactions categories: $e");
    } finally {
      notifyListeners();
    }
    return status;
  }
}