import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:warsha_app/utils/const_values.dart';
import 'base_url.dart';

class ShippingZoneService {

  Future<http.Response> getAllShippingZones(String token) async {
    try {
      final response = await http.get(
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token',
        },
        Uri.parse(Baseurl.getAllShippingZonesAPI),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));
      print(response.body);
      print(response.statusCode);

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to get shipping zones: $e');
    }
  }

  Future<http.Response> addShippingZone(String token, Map<String, dynamic> zoneData) async {
    try {
      final response = await http.post(
        Uri.parse(Baseurl.addShippingZoneAPI),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(zoneData),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to add shipping zone: $e');
    }
  }

  Future<http.Response> updateShippingZone(String token, int id, double shippingFee) async {
    try {
      final response = await http.put(
        Uri.parse("${Baseurl.updateShippingZoneAPI}/$id?shippingFee=$shippingFee"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to update shipping zone: $e');
    }
  }

  Future<http.Response> deleteShippingZone(String token, int id) async {
    try {
      final response = await http.delete(
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token',
        },
        Uri.parse("${Baseurl.deleteShippingZoneAPI}/$id"),
      ).timeout(const Duration(seconds: Constants.TIMEOUT));

      return response;
    } on TimeoutException {
      throw Exception('The request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to delete shipping zone: $e');
    }
  }
}
