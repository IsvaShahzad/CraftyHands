import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final String imageUrl;
  final double price;

  CartItem({
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double calculateTotal() {
    double total = 0;
    for (var item in _items) {
      total += item.price;
    }
    return total;
  }

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }
}

