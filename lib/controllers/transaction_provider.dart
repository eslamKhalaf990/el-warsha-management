import 'package:flutter/material.dart';

class TransactionsProvider extends ChangeNotifier {
  List allTransactions = [];
  List sortedTransactions = [];
  int? sortColumnIndex;
  bool sortAscending = true;

  void setTransactions(List transactions) {
    allTransactions = transactions;
    sortedTransactions = [...transactions];
    notifyListeners();
  }

  void sort<T>(
      Comparable<T> Function(dynamic t) getField,
      int columnIndex,
      bool ascending,
      ) {
    sortedTransactions.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    sortColumnIndex = columnIndex;
    sortAscending = ascending;
    notifyListeners();
  }
}
