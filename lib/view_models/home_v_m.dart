import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:warsha_app/models/daily_cash.dart';
import 'package:warsha_app/models/revenue_summary.dart';
import 'package:warsha_app/services/home_service.dart';
import 'package:warsha_app/view_models/user_v_m.dart';

class HomeVM extends ChangeNotifier {
  final HomeService _homeService;
  final UserViewModel _userViewModel;

  RevenueSummary? revenueSummary;
  List<DailyCashFlowModel>? dailyCashFlow;


  HomeVM(this._homeService, this._userViewModel){
    getRevenueSummary();
    getDailyCashFlow();
  }

  Future<String> getRevenueSummary() async {
    String status = "";
    try {
      final response = await _homeService.getRevenueSummary(_userViewModel.token);

      if (response.statusCode == 200) {

        status = "summary_fetched";

        final data = jsonDecode(response.body);
        revenueSummary = RevenueSummary.fromJson(data);
        debugPrint("Summary fetched successfully");
      } else {

        status = "summary_not_fetched";
        debugPrint("Failed to fetch summary: ${response.statusCode}");
      }

    } catch (e) {
      status = "summary_not_fetched";
      debugPrint("Error fetching summary: $e");
    } finally {
      notifyListeners();
    }
    return status;
  }

  Future<List<DailyCashFlowModel>?> getDailyCashFlow() async {
    dailyCashFlow = [];
    try {
      final response = await _homeService.getDailyCashFlow(_userViewModel.token);
      if (response.statusCode == 200) {
        final productsData = jsonDecode(response.body);
        final List<dynamic> data = productsData;
        dailyCashFlow = data.map((item) => DailyCashFlowModel.fromJson(item)).toList();
      } else {
        debugPrint("Failed to fetch cashFlow: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching cashFlow: $e");
    } finally {
      notifyListeners();
    }

    return dailyCashFlow;
  }
}