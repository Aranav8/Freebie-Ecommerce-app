import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderProvider with ChangeNotifier {
  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  Future<void> addOrder(
      List<Map<String, dynamic>> cartItems, double total) async {
    final newOrder = {
      'id': DateTime.now().toString(),
      'items': cartItems,
      'total': total,
      'date': DateTime.now().toIso8601String(),
      'status': 'In Transit',
    };

    _orders.add(newOrder);
    await _saveOrders();
    notifyListeners();
  }

  Future<void> _saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final String ordersJson = json.encode(_orders);
    await prefs.setString('orders', ordersJson);
  }

  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? ordersJson = prefs.getString('orders');
    if (ordersJson != null) {
      _orders = List<Map<String, dynamic>>.from(json.decode(ordersJson));
      notifyListeners();
    }
  }
}
