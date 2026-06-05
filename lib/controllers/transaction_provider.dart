import 'package:flutter/material.dart';
import 'package:warsha_app/models/transaction_model.dart';

class TransactionsProvider extends ChangeNotifier {
  List<BankTransaction> allTransactions = [];
  List<BankTransaction> sortedTransactions = [];
  int? sortColumnIndex;
  bool sortAscending = true;

  // Filtering
  final Map<String, String> _filters = {};
  DateTime? _startDate;
  DateTime? _endDate;

  final TextEditingController accountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  Comparable Function(BankTransaction t)? _sortFieldGetter;

  void setTransactions(List<BankTransaction> transactions) {
    allTransactions = transactions;
    _filterTransactions();
  }

  void sort<T>(
    Comparable<T> Function(BankTransaction t) getField,
    int columnIndex,
    bool ascending,
  ) {
    _sortFieldGetter = getField;
    sortColumnIndex = columnIndex;
    sortAscending = ascending;
    
    _applySort();
    notifyListeners();
  }

  void _applySort() {
    if (_sortFieldGetter != null) {
      sortedTransactions.sort((a, b) {
        final aValue = _sortFieldGetter!(a);
        final bValue = _sortFieldGetter!(b);
        return sortAscending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    }
  }

  void setDateRange(DateTimeRange? range) {
    if (range != null) {
      _startDate = range.start;
      _endDate = range.end;
    } else {
      _startDate = null;
      _endDate = null;
    }
    _filterTransactions();
  }

  void applyFilter(String key, String value) {
    if (value.trim().isEmpty) {
      _filters.remove(key);
    } else {
      _filters[key] = value.toLowerCase();
    }
    _filterTransactions();
  }

  void clearAllFilters() {
    _filters.clear();
    _startDate = null;
    _endDate = null;
    accountController.clear();
    categoryController.clear();
    typeController.clear();
    amountController.clear();
    descriptionController.clear();
    _filterTransactions();
  }

  void _filterTransactions() {
    sortedTransactions = allTransactions.where((t) {
      // Date Filter
      if (_startDate != null) {
        final normalizedStart = DateTime(_startDate!.year, _startDate!.month, _startDate!.day);
        if (t.createdAt.isBefore(normalizedStart)) return false;
      }
      if (_endDate != null) {
        final normalizedEnd = DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59);
        if (t.createdAt.isAfter(normalizedEnd)) return false;
      }

      // Text Filters
      for (var entry in _filters.entries) {
        final query = entry.value;
        String target = '';
        switch (entry.key) {
          case 'account':
            target = t.bankAccount.name.toLowerCase();
            break;
          case 'category':
            target = t.category.categoryName.toLowerCase();
            break;
          case 'type':
            target = t.transactionType.toLowerCase();
            break;
          case 'amount':
            target = t.amount.toString();
            break;
          case 'description':
            target = t.description.toLowerCase();
            break;
        }
        if (!target.contains(query)) return false;
      }

      return true;
    }).toList();

    // Re-apply sort
    _applySort();

    notifyListeners();
  }

  @override
  void dispose() {
    accountController.dispose();
    categoryController.dispose();
    typeController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
