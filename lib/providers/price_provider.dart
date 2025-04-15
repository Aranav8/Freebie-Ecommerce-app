import 'package:flutter/material.dart';
import 'cart_provider.dart';

class PriceProvider with ChangeNotifier {
  final CartProvider cartProvider;

  PriceProvider({required this.cartProvider}) {
    cartProvider.addListener(_calculatePrices);
    _calculatePrices();
  }

  double _subtotal = 0.0;
  double _platformFee = 5.0;
  double _deliveryCharges = 30.0;

  double get subtotal => _subtotal;
  double get platformFee => _platformFee;
  double get deliveryCharges => _deliveryCharges;
  double get total => _subtotal + _platformFee + _deliveryCharges;

  void _calculatePrices() {
    _subtotal = cartProvider.items.fold(0.0, (sum, item) {
      final quantity = item['quantity'] ?? 1;
      final price = double.tryParse(item['price'].toString()) ?? 0.0;
      return sum + (price * quantity);
    });

    notifyListeners();
  }

  @override
  void dispose() {
    cartProvider.removeListener(_calculatePrices);
    super.dispose();
  }
}
