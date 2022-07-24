import 'package:flutter/material.dart';

import '../screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: const Text('Hello Friend!'),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Orders'),
          onTap: () => Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName),
        ),
      ],
    ));
  }
}
