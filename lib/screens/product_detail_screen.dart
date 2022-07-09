import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
class ProductDetailScreen extends StatelessWidget {
  static String routeName = '/productScreen';

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) return const SizedBox.shrink();
    final productID = route.settings.arguments as String;
    final product = Provider.of<ProductsProvider>(context).findProductByID(productID);
    return Scaffold(appBar: AppBar(title:Text(product.title)),);
  }
}