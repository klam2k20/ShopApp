import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool _isFavorite = false;

  Product({
    required this.id, 
    required this.title,
    required this.description,  
    required this.price, 
    required this.imageUrl, 
    });

  bool get favorite {
    return _isFavorite;
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}