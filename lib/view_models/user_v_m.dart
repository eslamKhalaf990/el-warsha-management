import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warsha_app/services/user_service.dart';

class UserViewModel extends ChangeNotifier {
  bool isLoading = false;
  final UserService _userService;
  String? _token; // Use a private variable

  String get token => _token ?? "-";

  UserViewModel(this._userService) {
    // Automatically try to load the token when the ViewModel is initialized
    _loadToken();
  }

  // 1. Load token from storage on app start
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    notifyListeners();
  }

  Future<String> login(String username, String password) async {
    String status = "";
    try {
      isLoading = true;
      notifyListeners();

      final response = await _userService.login(username, password);

      if (response.statusCode == 200) {
        status = "logged_in";
        final rawToken = jsonDecode(response.body)["token"];

        // 2. Save token to persistent storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', rawToken);

        _token = rawToken;
        debugPrint("Logged in and token saved");
      } else {
        status = "failed_login";
      }
    } catch (e) {
      status = "failed_login";
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return status;
  }

  // 3. Clear token on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _token = null;
    notifyListeners();
  }
}