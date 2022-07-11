import 'package:flutter/material.dart';

import '../models/cartItem.dart';
import './product.dart';

class CartItemProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  void addCartItem(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(product.id,
          (existingCartItem) => CartItem(product, existingCartItem.quality+1));
    } else {
      _cartItems[product.id] = CartItem(product, 1);
    }
  }
}
