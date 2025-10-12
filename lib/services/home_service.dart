import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/utils/const_values.dart';

import 'base_url.dart';

class HomeService {

  // This class will handle the logic for attendance management.
  Future<http.Response> getRevenueSummary(String token) async {
    debugPrint("getRevenueSummary called with token: $token");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(
          Baseurl.getRevenueSummaryAPI,
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get your summary: $e');
    }
    return response;
  }
}
