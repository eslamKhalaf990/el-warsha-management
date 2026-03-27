import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/category_model.dart';
import 'package:warsha_app/services/category_service.dart';
import 'package:warsha_app/view_models/user_v_m.dart';

class CategoryVM extends ChangeNotifier {
  final CategoryService _categoryService;
  final UserViewModel _userViewModel;

  List<CategoryModel>? allCategories;
  bool isLoading = false;

  CategoryVM(this._categoryService, this._userViewModel) {
    initCategories();
  }

  void initCategories() async {
    await getAllCategories();
  }

  Future<String> getAllCategories() async {
    String status = "";
    isLoading = true;
    notifyListeners();

    try {
      final response = await _categoryService.getAllCategories(_userViewModel.token);

      if (response.statusCode == 200) {
        status = "categories_fetched";
        final data = jsonDecode(response.body) as List;
        allCategories = data.map((item) => CategoryModel.fromJson(item)).toList();
        debugPrint("Categories fetched successfully");
      } else {
        status = "categories_not_fetched";
        debugPrint("Failed to fetch categories: ${response.statusCode}");
      }
    } catch (e) {
      status = "categories_not_fetched";
      debugPrint("Error fetching categories: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return status;
  }

  Future<String> addCategory(Map<String, dynamic> categoryData) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();

      final response = await _categoryService.addCategory(_userViewModel.token, categoryData);

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint("Category added successfully");
        await getAllCategories(); // Refresh the list
        status = "category_added";
      } else {
        debugPrint("Failed to add category: ${response.statusCode}");
        status = "category_not_added";
      }
    } catch (e) {
      debugPrint("Error adding category: $e");
      status = "category_not_added";
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return status;
  }

  Future<String> updateCategory(int id, Map<String, dynamic> categoryData) async {
    String status = "";
    try {
      final response = await _categoryService.updateCategory(_userViewModel.token, id, categoryData);

      if (response.statusCode == 200) {
        debugPrint("Category updated successfully");
        await getAllCategories(); // Refresh the list
        status = "category_updated";
      } else {
        status = "category_not_updated";
      }
    } catch (e) {
      debugPrint("Error updating category: $e");
      status = "category_not_updated";
    } finally {
      notifyListeners();
    }
    return status;
  }

  Future<String> deleteCategory(int id) async {
    String status = "";
    try {
      final response = await _categoryService.deleteCategory(_userViewModel.token, id);

      if (response.statusCode == 200 || response.statusCode == 204) {
        status = "category_deleted";
        debugPrint("Category deleted successfully");
        await getAllCategories(); // Refresh the list
      } else {
        status = "category_not_deleted";
      }
    } catch (e) {
      status = "category_not_deleted";
      debugPrint("Error deleting category: $e");
    } finally {
      notifyListeners();
    }
    return status;
  }
}
