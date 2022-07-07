import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static String routeName = '/productScreen';

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) return const SizedBox.shrink();
    final productID = route.settings.arguments as String;
    return Scaffold(appBar: AppBar(title:Text(productID)),);
  }
}