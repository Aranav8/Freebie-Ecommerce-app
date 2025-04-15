import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikedItemProvider with ChangeNotifier {
  final Set<int> _likedItems = {};

  Set<int> get likedItems => _likedItems;

  LikedItemProvider() {
    _loadLikedItems();
  }

  Future<void> _loadLikedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final likedItemsString = prefs.getStringList('liked_items') ?? [];
    _likedItems.addAll(likedItemsString.map(int.parse));
    notifyListeners();
  }

  Future<void> _saveLikedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final likedItemsString =
        _likedItems.map((index) => index.toString()).toList();
    await prefs.setStringList('liked_items', likedItemsString);
  }

  void toggleLikedItem(int index) {
    if (_likedItems.contains(index)) {
      _likedItems.remove(index);
    } else {
      _likedItems.add(index);
    }
    _saveLikedItems();
    notifyListeners();
  }

  bool isLiked(int index) {
    return _likedItems.contains(index);
  }
}
