import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:warsha_app/services/user_service.dart';

class UserViewModel extends ChangeNotifier {
  bool isLoading = false;
  final UserService _userService;
  String token = "-";

  UserViewModel(this._userService);

  Future<String> login (String username, String password) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();
      final response = await _userService.login(username, password);
      if (response.statusCode == 200) {
        status = "logged_in";
        token = jsonDecode(response.body)["token"];
        debugPrint("Logged in successfully");
      } else {
        status = "failed_login";
        debugPrint("Failed to add customer: ${response.statusCode}");
      }
    } catch (e) {
      status = "failed_login";
      debugPrint("Error Logging In: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return status;
  }

}