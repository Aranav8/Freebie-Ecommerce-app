import 'package:flutter/material.dart';

class SelectedAddressProvider with ChangeNotifier {
  String _selectedAddress = '925 S Chugach St #APT 10, Alaska 99645';
  String _place = 'Home';

  String get selectedAddress => _selectedAddress;
  String get place => _place;

  void updateAddress(String newAddress, String newPlace) {
    _selectedAddress = newAddress;
    _place = newPlace;
    notifyListeners();
  }
}
