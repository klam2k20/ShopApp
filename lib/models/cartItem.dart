import '../providers/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem(this.product, this.quantity);
}