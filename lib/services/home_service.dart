import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/date.dart';

import 'base_url.dart';

class HomeService {

  // --- Existing Endpoints ---

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

  Future<http.Response> getTotalSoldProducts(String token) async {
    debugPrint("getTotalSoldProducts called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(
          "${Baseurl.getTotalSoldProductsAPI}?date=${DateHelper.formatDateMY(DateTime.now().toString())}",
        ),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get your total sold products: $e');
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
      throw Exception('Failed to get your daily cash flow: $e');
    }
    return response;
  }

  // --- NEW: Customer Analysis Endpoints ---

  Future<http.Response> getLoyalCustomers(String token) async {
    debugPrint("getLoyalCustomers called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getLoyalCustomersAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get loyal customers: $e');
    }
    return response;
  }

  Future<http.Response> getVipCustomers(String token) async {
    debugPrint("getVipCustomers called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getVipCustomersAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get VIP customers: $e');
    }
    return response;
  }

  Future<http.Response> getAtRiskCustomers(String token) async {
    debugPrint("getAtRiskCustomers called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getAtRiskCustomersAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get at-risk customers: $e');
    }
    return response;
  }

  Future<http.Response> getDiscountSeekers(String token) async {
    debugPrint("getDiscountSeekers called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getDiscountSeekersAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get discount seekers: $e');
    }
    return response;
  }

  // --- NEW: Sales & Market Performance Endpoints ---

  Future<http.Response> getAverageBasketSize(String token) async {
    debugPrint("getAverageBasketSize called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getAverageBasketSizeAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get average basket size: $e');
    }
    return response;
  }

  Future<http.Response> getRevenueBySource(String token) async {
    debugPrint("getRevenueBySource called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getRevenueBySourceAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get revenue by source: $e');
    }
    return response;
  }

  Future<http.Response> getTopPerformers(String token) async {
    debugPrint("getTopPerformers called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getTopPerformersAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get top performers: $e');
    }
    return response;
  }

  Future<http.Response> getGovernoratePerformance(String token) async {
    debugPrint("getGovernoratePerformance called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getGovernoratePerformanceAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get governorate performance: $e');
    }
    return response;
  }

  Future<http.Response> getDailyRevenueReport(String token) async {
    debugPrint("getDailyRevenueReport called");
    http.Response response;
    try {
      response = await http.get(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getDailyRevenueReportAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get daily revenue report: $e');
    }
    return response;
  }
}