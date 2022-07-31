import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cartItems_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;

  const CartItem(this.id, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    final cartDataProvider =
        Provider.of<CartItemProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete),
      ),
      onDismissed: (_) => cartDataProvider.removeCartItem(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (cxt) => AlertDialog(
                  content: Text('Do you want to remove $title from the cart?'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(cxt).pop(true),
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () => Navigator.of(cxt).pop(false),
                        child: const Text('No'))
                  ],
                ));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: FittedBox(
                      child: Text(
                    '\$$price',
                    style: const TextStyle(color: Colors.white),
                  ))),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
