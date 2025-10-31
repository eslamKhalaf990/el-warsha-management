import 'package:flutter/material.dart';

class GovernorateProvider with ChangeNotifier {
  String? _selectedQuery;

  String? get selectedGovernorate => _selectedQuery;

  final List<String> governorates = [
    "القاهرة",
    "الجيزة",
    "الإسكندرية",
    "بورسعيد",
    "السويس",
    "الدقهلية",
    "الشرقية",
    "القليوبية",
    "كفر الشيخ",
    "الغربية",
    "المنوفية",
    "البحيرة",
    "الإسماعيلية",
    "المنيا",
    "بني سويف",
    "الفيوم",
    "أسيوط",
    "سوهاج",
    "قنا",
    "الأقصر",
    "أسوان",
    "البحر الأحمر",
    "الوادي الجديد",
    "مطروح",
    "شمال سيناء",
    "جنوب سيناء",
  ];

  void selectGovernorate(String governorate) {
    _selectedQuery = governorate;
    notifyListeners();
  }

  void searchByCustomer(String query){
    _selectedQuery = query;
    notifyListeners();
  }

  void selectPayment(String query) {
    _selectedQuery = query;
    notifyListeners();
  }

  void removeFilter (){
    _selectedQuery = null;
    notifyListeners();
  }
}
