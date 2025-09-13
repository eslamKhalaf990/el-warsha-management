import 'package:flutter/material.dart';

class CustomerProvider extends ChangeNotifier {
  // TextEditingControllers
  final TextEditingController governorate = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();

  // Dispose controllers
  @override
  void dispose() {
    governorate.dispose();
    phone.dispose();
    email.dispose();
    address.dispose();
    super.dispose();
  }

  void clearCustomer (){
    governorate.clear();
    phone.clear();
    email.clear();
    address.clear();
  }
}