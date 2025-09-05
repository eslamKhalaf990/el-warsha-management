import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/services/customers_services.dart';

class CustomerVM extends ChangeNotifier {
  final CustomerService _customerService;

  bool isLoading = false;

  Future<List<CustomerModel>>? allCustomers;

  final TextEditingController searchController = TextEditingController();

  CustomerVM(this._customerService) {
    initAllCustomers();
    searchController.addListener(() {
      notifyListeners();
    });
  }


  void initAllCustomers () {
    allCustomers = getAllCustomers();
    notifyListeners();
  }

  Future<List<CustomerModel>> getAllCustomers() async {
    List<CustomerModel> products = [];
    try {
      isLoading = true;
      final response = await _customerService.getAllCustomers();
      if (response.statusCode == 200) {
        final productsData = jsonDecode(response.body);
        final List<dynamic> data = productsData;
        products = data.map((item) => CustomerModel.fromJson(item)).toList();
      } else {
        debugPrint("Failed to fetch products: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return products;
  }
  Future<String> addCustomer(String name, String email,
      String phone, String address) async {
    String status = "";
    try {
      isLoading = true;
      CustomerModel customer = CustomerModel.add(name: name, email: email, phone: phone, address: address);
      final response = await _customerService.addCustomer(customer);
      if (response.statusCode == 201) {
        status = "customer_added";
        debugPrint("customer added successfully");
      } else {
        status = "customer_not_added";
        debugPrint("Failed to add customer: ${response.statusCode}");
      }
    } catch (e) {
      status = "customer_not_added";
      debugPrint("Error fetching customer: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return status;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
