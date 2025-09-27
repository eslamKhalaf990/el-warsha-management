import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/services/customers_services.dart';
import 'package:warsha_app/view_models/user_v_m.dart';

class CustomerVM extends ChangeNotifier {
  final CustomerService _customerService;
  final UserViewModel _userViewModel;


  bool isLoading = false;

  Future<List<CustomerModel>>? allCustomers;

  final TextEditingController searchController = TextEditingController();

  CustomerVM(this._customerService, this._userViewModel) {
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
      final response = await _customerService.getAllCustomers(_userViewModel.token);
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

  Future<String> addCustomer(String name, String governorate,
      String phone, String address) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();
      CustomerModel customer = CustomerModel.add(name: name, governorate: governorate, phone: phone, address: address);
      final response = await _customerService.addCustomer(customer, _userViewModel.token);
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

  Future<String> updateCustomer(String id, String name, String governorate,
      String phone, String address) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();

      CustomerModel customer = CustomerModel.add(
        name: name,
        governorate: governorate,
        phone: phone,
        address: address,
      );

      final response = await _customerService.updateCustomer(id, customer,_userViewModel.token );

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
