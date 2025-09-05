import 'package:flutter/material.dart';

class CustomerProvider extends ChangeNotifier {
  // TextEditingControllers
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();

  // Dispose controllers
  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    address.dispose();
    super.dispose();
  }

  void clearCustomer (){
    name.clear();
    phone.clear();
    email.clear();
    address.clear();
  }
}