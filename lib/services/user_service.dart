import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warsha_app/utils/const_values.dart';
import 'base_url.dart';

class UserService {
  Future<http.Response> login (String username, String password) async {
    debugPrint("login using $username account");
    http.Response response;
    try {
      response = await http.post(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          Uri.parse(
            Baseurl.loginApi,
          ),
          body: jsonEncode({
            "username": username,
            "password": password,
          })
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to login with these credentials: $e');
    }
    return response;


  }
}