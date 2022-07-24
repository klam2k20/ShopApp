import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cartItems_provider.dart';
import '../providers/orders_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Consumer<CartItemProvider>(
        builder: (context, cart, child) => Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.cartTotal.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          Provider.of<OrdersProvider>(context, listen: false)
                              .addOrder(
                            cart.cartItems.values.toList(),
                            cart.cartTotal,
                          );
                          cart.clear();
                        },
                        child: const Text('ORDER NOW'))
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartItems.length,
                itemBuilder: (ctx, i) => CartItem(
                    cart.cartItems.keys.toList()[i],
                    cart.cartItems.values.toList()[i].product.title,
                    cart.cartItems.values.toList()[i].product.price,
                    cart.cartItems.values.toList()[i].quantity),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
