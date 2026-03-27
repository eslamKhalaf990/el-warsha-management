import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warsha_app/utils/const_values.dart';
import 'base_url.dart';

class CategoryService {

  // Fetch all categories
  Future<http.Response> getAllCategories(String token) async {
    debugPrint("getAllCategories called");
    try {
      final response = await http.get(
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getAllCategoriesAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      debugPrint("Response: ${response.body}");
      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  // Create a new category
  Future<http.Response> addCategory(String token, Map<String, dynamic> categoryData) async {
    debugPrint("addCategory called");
    try {
      final response = await http.post(
        Uri.parse(Baseurl.addCategoryAPI),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(categoryData),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }

  // Update existing category
  Future<http.Response> updateCategory(String token, int id, Map<String, dynamic> categoryData) async {
    debugPrint("updateCategory called for ID: $id");
    try {
      final response = await http.put(
        Uri.parse("${Baseurl.addCategoryAPI}/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(categoryData),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  // Delete Category
  Future<http.Response> deleteCategory(String token, int id) async {
    debugPrint("deleteCategory called for ID: $id");
    try {
      final response = await http.delete(
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token',
        },
        Uri.parse("${Baseurl.addCategoryAPI}/$id"),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }
}
