import 'package:flutter/material.dart';

class CustomerProvider extends ChangeNotifier {
  // TextEditingControllers
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController governorate = TextEditingController();
  final TextEditingController address = TextEditingController();

  // Dispose controllers
  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    governorate.dispose();
    address.dispose();
    super.dispose();
  }

  void clearCustomer (){
    name.clear();
    phone.clear();
    governorate.clear();
    address.clear();
  }
}