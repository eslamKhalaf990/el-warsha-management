import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warsha_app/models/transaction_add_model.dart';
import 'package:warsha_app/utils/const_values.dart';

import 'base_url.dart';

class AccountingService {

  // This class will handle the logic for attendance management.
  Future<http.Response> getAccountsBalance(String token, {String? password}) async {
    debugPrint("getAccountBalance called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(
          "${Baseurl.getAccountsBalanceAPI}?password=${password ?? ""}",
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      debugPrint(response.body);

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get your accounts: $e');
    }
    return response;
  }

  Future<http.Response> deleteAllTransactions(String token) async {
    debugPrint("deleteAllTransactions called");
    http.Response response;
    try {
      response = await http.delete(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(
          Baseurl.deleteAllTransactionsAPI,
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to delete your transactions: $e');
    }
    return response;
  }

  Future<http.Response> getTransactions(String token) async {
    debugPrint("getTransactions called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(
          Baseurl.getTransactionsAPI,
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get your transactions: $e');
    }
    return response;
  }

  Future<http.Response> getTransactionCategories(String token) async {
    debugPrint("getTransactionCategories called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(
          Baseurl.getTransactionCategoriesAPI,
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get your transaction categories: $e');
    }
    return response;
  }

  Future<http.Response> addTransaction(String token, TransactionModel transaction) async {
    debugPrint("addTransaction called");

    try {
      final response = await http.post(
        Uri.parse(Baseurl.addTransactionAPI),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(transaction.toJson()),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add your transaction: $e');
    }
  }


}
