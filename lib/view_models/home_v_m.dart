import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/analysis_models/analysis.dart';

// Existing Models
import 'package:warsha_app/models/daily_cash.dart';
import 'package:warsha_app/models/revenue_summary.dart';
import 'package:warsha_app/models/top_products.dart';

import 'package:warsha_app/services/home_service.dart';
import 'package:warsha_app/view_models/user_v_m.dart';

class HomeVM extends ChangeNotifier {
  final HomeService _homeService;
  final UserViewModel _userViewModel;

  // --- CORE PROPERTIES ---
  RevenueSummary? revenueSummary;
  List<DailyCashFlowModel>? dailyCashFlow;
  List<TopProduct>? topProducts;

  // --- CUSTOMER INSIGHTS PROPERTIES ---
  List<CustomerAnalysis>? loyalCustomers;
  List<CustomerAnalytics>? vipCustomers;
  List<CustomerRetention>? atRiskCustomers;
  List<CustomerDiscount>? discountSeekers;

  // --- SALES & MARKET PERFORMANCE PROPERTIES ---
  double? averageBasketSize;
  List<OrderSourceAnalytics>? revenueBySource;
  List<CustomerAnalytics>? topPerformers;
  List<GovernorateAnalytics>? governoratePerformance;
  List<DailySales>? dailyRevenueReport;

  HomeVM(this._homeService, this._userViewModel) {
    initHome();
  }

  /// Initializes all dashboard data concurrently
  Future<void> initHome() async {
    await Future.wait([
      getRevenueSummary(),
      getDailyCashFlow(),
      getTotalSoldProducts(),
      getLoyalCustomers(),
      getVipCustomers(),
      getAtRiskCustomers(),
      getDiscountSeekers(),
      getAverageBasketSize(),
      getRevenueBySource(),
      getTopPerformers(),
      getGovernoratePerformance(),
      getDailyRevenueReport(),
    ]);
  }

  // ==========================================
  //         EXISTING CORE ENDPOINTS
  // ==========================================

  Future<String> getRevenueSummary() async {
    String status = "";
    try {
      final response = await _homeService.getRevenueSummary(_userViewModel.token);
      if (response.statusCode == 200) {
        status = "summary_fetched";
        final data = jsonDecode(response.body);
        revenueSummary = RevenueSummary.fromJson(data);
      } else {
        status = "summary_not_fetched";
      }
    } catch (e) {
      status = "summary_not_fetched";
      debugPrint("Error fetching summary: $e");
    } finally {
      notifyListeners();
    }
    return status;
  }

  Future<String> getTotalSoldProducts() async {
    String status = "";
    try {
      final response = await _homeService.getTotalSoldProducts(_userViewModel.token);
      if (response.statusCode == 200) {
        status = "top_products_fetched";
        final List<dynamic> data = jsonDecode(response.body);
        topProducts = data.map((item) => TopProduct.fromJson(item)).toList();
      } else {
        status = "top_products_not_fetched";
      }
    } catch (e) {
      status = "top_products_not_fetched";
      debugPrint("Error fetching top products: $e");
    } finally {
      notifyListeners();
    }
    return status;
  }

  Future<List<DailyCashFlowModel>?> getDailyCashFlow() async {
    try {
      final response = await _homeService.getDailyCashFlow(_userViewModel.token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        dailyCashFlow = data.map((item) => DailyCashFlowModel.fromJson(item)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching cashFlow: $e");
    } finally {
      notifyListeners();
    }
    return dailyCashFlow;
  }

  // ==========================================
  //         CUSTOMER ANALYSIS MAPPING
  // ==========================================

  Future<void> getLoyalCustomers() async {
    try {
      final response = await _homeService.getLoyalCustomers(_userViewModel.token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        loyalCustomers = data.map((json) => CustomerAnalysis.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching loyal customers: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getVipCustomers() async {
    try {
      final response = await _homeService.getVipCustomers(_userViewModel.token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        vipCustomers = data.map((json) => CustomerAnalytics.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching VIP customers: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getAtRiskCustomers() async {
    try {
      final response = await _homeService.getAtRiskCustomers(_userViewModel.token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        atRiskCustomers = data.map((json) => CustomerRetention.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching at-risk customers: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getDiscountSeekers() async {
    try {
      final response = await _homeService.getDiscountSeekers(_userViewModel.token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        discountSeekers = data.map((json) => CustomerDiscount.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching discount seekers: $e");
    } finally {
      notifyListeners();
    }
  }

  // ==========================================
  //     SALES & MARKET PERFORMANCE MAPPING
  // ==========================================
// --- Updated Model Property in HomeVM ---

// --- Updated Mapping Method ---
  Future<void> getGovernoratePerformance() async {
    try {
      final response = await _homeService.getGovernoratePerformance(_userViewModel.token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        // Mapping to the specific GovernorateAnalytics model
        governoratePerformance = data.map((json) => GovernorateAnalytics.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching governorate performance: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getAverageBasketSize() async {
    try {
      final response = await _homeService.getAverageBasketSize(_userViewModel.token);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is num) {
          averageBasketSize = data.toDouble();
        } else if (data is Map && data.containsKey('average')) {
          averageBasketSize = (data['average'] as num).toDouble();
        }
      }
    } catch (e) {
      debugPrint("Error fetching average basket size: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getRevenueBySource() async {
    try {
      final response = await _homeService.getRevenueBySource(_userViewModel.token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        revenueBySource = data.map((json) => OrderSourceAnalytics.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching revenue by source: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getTopPerformers() async {
    try {
      final response = await _homeService.getTopPerformers(_userViewModel.token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        topPerformers = data.map((json) => CustomerAnalytics.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching top performers: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getDailyRevenueReport() async {
    try {
      final response = await _homeService.getDailyRevenueReport(_userViewModel.token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        dailyRevenueReport = data.map((json) => DailySales.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching daily revenue report: $e");
    } finally {
      notifyListeners();
    }
  }
}