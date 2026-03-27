import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/vendor.dart';
import 'package:warsha_app/services/vendors_service.dart';
import 'package:warsha_app/view_models/user_v_m.dart';

class VendorVM extends ChangeNotifier {
  final VendorService _vendorService;
  final UserViewModel _userViewModel;

  List<Vendor>? allVendors;
  bool isLoading = false;

  VendorVM(this._vendorService, this._userViewModel) {
    initVendors();
  }

  void initVendors() async {
    await getAllVendors();
  }

  Future<String> getAllVendors() async {
    String status = "";
    isLoading = true;
    notifyListeners();

    try {
      final response = await _vendorService.getAllVendors(_userViewModel.token);

      if (response.statusCode == 200) {
        status = "vendors_fetched";
        final data = jsonDecode(response.body) as List;
        allVendors = data.map((item) => Vendor.fromJson(item)).toList();
        debugPrint("Vendors fetched successfully");
      } else {
        status = "vendors_not_fetched";
        debugPrint("Failed to fetch vendors: ${response.statusCode}");
      }
    } catch (e) {
      status = "vendors_not_fetched";
      debugPrint("Error fetching vendors: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return status;
  }

  Future<String> addVendor(Map<String, dynamic> vendorData) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();

      final response = await _vendorService.addVendor(_userViewModel.token, vendorData);

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint("Vendor added successfully");
        await getAllVendors(); // Refresh the list
        status = "vendor_added";
      } else {
        debugPrint("Failed to add vendor: ${response.statusCode}");
        status = "vendor_not_added";
      }
    } catch (e) {
      debugPrint("Error adding vendor: $e");
      status = "vendor_not_added";
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return status;
  }

  Future<String> updateVendor(int id, Map<String, dynamic> vendorData) async {
    String status = "";
    try {
      final response = await _vendorService.updateVendor(_userViewModel.token, id, vendorData);

      if (response.statusCode == 200) {
        debugPrint("Vendor updated successfully");
        await getAllVendors(); // Refresh the list
        status = "vendor_updated";
      } else {
        status = "vendor_not_updated";
      }
    } catch (e) {
      debugPrint("Error updating vendor: $e");
      status = "vendor_not_updated";
    } finally {
      notifyListeners();
    }
    return status;
  }

  Future<String> deleteVendor(int id) async {
    String status = "";
    try {
      final response = await _vendorService.deleteVendor(_userViewModel.token, id);

      if (response.statusCode == 200 || response.statusCode == 204) {
        status = "vendor_deleted";
        debugPrint("Vendor soft-deleted successfully");
        await getAllVendors(); // Refresh the list to hide the deleted vendor
      } else {
        status = "vendor_not_deleted";
      }
    } catch (e) {
      status = "vendor_not_deleted";
      debugPrint("Error deleting vendor: $e");
    } finally {
      notifyListeners();
    }
    return status;
  }
}