import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warsha_app/views/accounting/accounting.dart';
import 'package:warsha_app/views/customers/customers.dart';
import 'package:warsha_app/views/home/home.dart';
import 'package:warsha_app/views/orders/new_order_ui.dart';
import 'package:warsha_app/views/orders/orders.dart';
import 'package:warsha_app/views/products/products.dart';

class Navigation extends ChangeNotifier {
  List<Widget> pages = [
    const HomeCashFlow(),
    const Products(),
    const NewOrderUi(),
    const Customers(),
    const Accounting(),
  ];

  int page = 0;

  void updatePage(int state){
    page = state;
    notifyListeners();
  }

  Widget get view => pages[page];
}