import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warsha_app/views/accounting/accounting_beta.dart';
import 'package:warsha_app/views/categories/categories.dart';
import 'package:warsha_app/views/customers/customers.dart';
import 'package:warsha_app/views/home/dashboard.dart';
import 'package:warsha_app/views/orders/orders.dart';
import 'package:warsha_app/views/products/products.dart';
import 'package:warsha_app/views/shipping_zones/shipping_zones.dart';
import 'package:warsha_app/views/vendors/vendors.dart';

class Navigation extends ChangeNotifier {
  List<Widget> pages = [
    const Dashboard(),
    const Products(),
    const Orders(),
    const Customers(),
    const Categories(),
    const Vendors(),
    const ShippingZones(),
    const Accounting(),
  ];

  int page = 0;

  void updatePage(int state){
    page = state;
    notifyListeners();
  }

  Widget get view => pages[page];
}