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
    List<CustomerModel> customers = [];
    try {
      isLoading = true;
      final response = await _customerService.getAllCustomers();
      if (response.statusCode == 200) {
        final productsData = jsonDecode(response.body);
        final List<dynamic> data = productsData;
        customers = data.map((item) => CustomerModel.fromJson(item)).toList();
      } else {
        debugPrint("Failed to fetch customers: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching customers: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return customers;
  }

  Future<String> addCustomer(String name, String email,
      String phone, String address) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();
      CustomerModel customer = CustomerModel.add(name: name, governorate: email, phone: phone, address: address);
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

  Future<String> updateCustomer(String id, String name, String email,
      String phone, String address) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();

      CustomerModel customer = CustomerModel.add(
        name: name,
        governorate: email,
        phone: phone,
        address: address,
      );

      final response = await _customerService.updateCustomer(id, customer);

      if (response.statusCode == 200) {
        status = "customer_updated";
        debugPrint("Customer updated successfully");
      } else {
        status = "customer_not_updated";
        debugPrint("Failed to update customer: ${response.statusCode}");
      }
    } catch (e) {
      status = "customer_not_updated";
      debugPrint("Error updating customer: $e");
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
