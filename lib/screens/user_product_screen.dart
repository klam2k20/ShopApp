import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/appDrawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products_provider.dart';

class UserProductScreen extends StatelessWidget {
  static String routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      drawer: AppDrawer(),
      body: Consumer<ProductsProvider>(
          builder: (_, products, child) => ListView.builder(
                itemCount: products.products.length,
                itemBuilder: (_, i) => UserProductItem(
                    products.products[i].title, products.products[i].imageUrl),
              )),
    );
  }
}
