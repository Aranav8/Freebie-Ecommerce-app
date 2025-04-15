import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  CartProvider() {
    _loadCart();
  }

  List<Map<String, dynamic>> get items => _items;

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode(_items);
    await prefs.setString('cart', cartJson);
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final List<dynamic> cartList = jsonDecode(cartJson);
      _items.clear();
      _items.addAll(cartList.map((item) => Map<String, dynamic>.from(item)));
      notifyListeners();
    }
  }

  void addItem(Map<String, dynamic> product, String size) {
    _items.add({
      ...product,
      'size': size,
      'quantity': 1,
    });
    _saveCart();
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _saveCart();
    notifyListeners();
  }

  void updateItemQuantity(int index, int quantity) {
    if (quantity > 0) {
      _items[index]['quantity'] = quantity;
      _saveCart();
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }
}
