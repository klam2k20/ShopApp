import 'package:flutter/material.dart';

import '../models/cartItem.dart';

class OrderItem {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime orderDate;

  const OrderItem(
      {required this.id,
      required this.total,
      required this.products,
      required this.orderDate});
}

class OrdersProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> order, double total) {
  _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          total: total,
          products: order,
          orderDate: DateTime.now(),
        ));
    notifyListeners();
  }
}
