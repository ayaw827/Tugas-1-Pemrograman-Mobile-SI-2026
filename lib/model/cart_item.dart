// lib/models/cart_item.dart
import 'product.dart';

class CartItem {
  final AlbumTaste product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}
