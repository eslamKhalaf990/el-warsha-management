import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warsha_app/views/customers/customers.dart';
import 'package:warsha_app/views/orders/orders.dart';
import 'package:warsha_app/views/products/products.dart';

class Navigation extends ChangeNotifier {
  List<Widget> pages = [
    const Products(),
    const Orders(),
    const Customers()
  ];

  int page = 0;

  void updatePage(int state){
    page = state;
    notifyListeners();
  }

  Widget get view => pages[page];
}