import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../providers/cartItems_provider.dart';
import '../screens/cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedOption) {
              setState(() {
                if (selectedOption == FilterOptions.Favorites) {
                  _isFavorite = true;
                } else {
                  _isFavorite = false;
                }
              });
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 10),
                    const Text('Favorites')
                  ],
                ),
              ),
              PopupMenuItem(
                value: FilterOptions.All,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.label,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 10),
                    const Text('All')
                  ],
                ),
              )
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<CartItemProvider>(
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName)
            ),
            builder: (_, cart, c) =>
                Badge(value: cart.cartCount.toString(), child: c!),
          )
        ],
      ),
      body: ProductsGrid(_isFavorite),
    );
  }
}
