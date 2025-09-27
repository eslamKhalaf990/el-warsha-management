import 'package:flutter/material.dart';

class GovernorateProvider with ChangeNotifier {
  String? _selectedGovernorate;

  String? get selectedGovernorate => _selectedGovernorate;

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
    _selectedGovernorate = governorate;
    notifyListeners();
  }
  void removeFilter (){
    _selectedGovernorate = null;
    notifyListeners();
  }
}
