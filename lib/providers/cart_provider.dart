import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get total => _items.fold(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );

  int get itemCount => _items.length;

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((i) => i.id == item.id);
    if (existingIndex >= 0) {
      _items[existingIndex] = CartItem(
        id: item.id,
        name: item.name,
        description: item.description,
        price: item.price,
        imageUrl: item.imageUrl,
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (quantity > 0) {
        _items[index] = CartItem(
          id: _items[index].id,
          name: _items[index].name,
          description: _items[index].description,
          price: _items[index].price,
          imageUrl: _items[index].imageUrl,
          quantity: quantity,
        );
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
