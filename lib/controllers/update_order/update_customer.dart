import 'package:flutter/material.dart';

import '../../order_upgrading/models/customerModel.dart';

class UpdateCustomerProvider extends ChangeNotifier {
  // TextEditingControllers
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController governorate = TextEditingController();
  final TextEditingController address = TextEditingController();

  // Dispose controllers
  @override
  void dispose() {
    governorate.dispose();
    phone.dispose();
    governorate.dispose();
    address.dispose();
    super.dispose();
  }

  void loadCustomer (CustomerModel customer){
    name.text = customer.fullName;
    phone.text = customer.phone;
    governorate.text = customer.governorate;
    address.text = customer.address;
    notifyListeners();
  }

  void clearCustomer (){
    governorate.clear();
    phone.clear();
    governorate.clear();
    address.clear();
  }
}
