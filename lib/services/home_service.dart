import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warsha_app/utils/const_values.dart';

import 'base_url.dart';

class HomeService {

  // This class will handle the logic for attendance management.
  Future<http.Response> getRevenueSummary(String token) async {
    debugPrint("getRevenueSummary called");
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

  Future<http.Response> getDailyCashFlow(String token) async {
    debugPrint("getDailyCashFlow called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(
          Baseurl.getDailyCashFlowAPI,
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {

      throw Exception('The request timed out. Please try again later.');
    } catch (e) {

      throw Exception('Failed to get your dail cash flow: $e');
    }
    return response;
  }
}
