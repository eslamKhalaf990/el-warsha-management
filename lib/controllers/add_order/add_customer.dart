import 'package:flutter/material.dart';

class CustomerProvider extends ChangeNotifier {
  // TextEditingControllers
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController governorate = TextEditingController();
  final TextEditingController secondaryPhone = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController address = TextEditingController();

  // Dispose controllers
  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    governorate.dispose();
    secondaryPhone.dispose();
    city.dispose();
    address.dispose();
    super.dispose();
  }

  void clearCustomer (){
    name.clear();
    phone.clear();
    governorate.clear();
    city.clear();
    secondaryPhone.clear();
    address.clear();
  }
}