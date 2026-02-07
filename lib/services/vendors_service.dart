import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warsha_app/utils/const_values.dart';
// Assuming you create a Vendor model based on our backend work
// import 'package:warsha_app/models/vendor_model.dart';

import 'base_url.dart';

class VendorService {

  // Fetch all active vendors
  Future<http.Response> getAllVendors(String token) async {
    debugPrint("getAllVendors called");
    try {
      final response = await http.get(
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getVendorsAPI), // Define this in your Baseurl class
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      debugPrint("Response: ${response.body}");
      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get vendors: $e');
    }
  }

  // Create a new vendor
  Future<http.Response> addVendor(String token, Map<String, dynamic> vendorData) async {
    debugPrint("addVendor called");
    try {
      final response = await http.post(
        Uri.parse(Baseurl.addVendorAPI),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(vendorData),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add vendor: $e');
    }
  }

  // Update existing vendor
  Future<http.Response> updateVendor(String token, int id, Map<String, dynamic> vendorData) async {
    debugPrint("updateVendor called for ID: $id");
    try {
      final response = await http.put(
        Uri.parse("${Baseurl.updateVendorAPI}/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(vendorData),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to update vendor: $e');
    }
  }

  // Soft Delete Vendor (This calls your @DeleteMapping in Spring Boot)
  Future<http.Response> deleteVendor(String token, int id) async {
    debugPrint("deleteVendor called for ID: $id");
    try {
      final response = await http.delete(
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token',
        },
        Uri.parse("${Baseurl.deleteVendorAPI}/$id"),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to delete vendor: $e');
    }
  }
}