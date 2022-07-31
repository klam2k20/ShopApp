import 'package:flutter/material.dart';

import '../models/cartItem.dart';
import './product.dart';

class CartItemProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  double get cartTotal {
    return _cartItems.values
        .fold(0, (total, item) => total + (item.quantity * item.product.price));
  }

  int get cartCount {
    return _cartItems.values.fold(0, (total, item) => total + item.quantity);
  }

  void addCartItem(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(
          product.id,
          (existingCartItem) =>
              CartItem(product, existingCartItem.quantity + 1));
    } else {
      _cartItems[product.id] = CartItem(product, 1);
    }
    notifyListeners();
  }

  void removeCartItem(String productID) {
    _cartItems.remove(productID);
    notifyListeners();
  }

  void removeSingleCartItem(Product product) {
    if (!_cartItems.containsKey(product.id)) {
      return;
    }
    if (_cartItems[product.id]!.quantity > 1) {
      _cartItems.update(
          product.id,
          (existingCartItem) =>
              CartItem(product, existingCartItem.quantity - 1));
    } else {
      _cartItems.remove(product.id);
    }
    notifyListeners();
  }

  void clear() {
    _cartItems.clear();
    notifyListeners();
  }
}
