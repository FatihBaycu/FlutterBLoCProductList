import 'dart:async';

import 'package:flutter_bloc_pattern/data/cart_service.dart';
import 'package:flutter_bloc_pattern/models/cart.dart';

class CartBloc {
  final cartStreamController = StreamController.broadcast();

  Stream get getStream => cartStreamController.stream;

  void addToCart(Cart item) {
    CartService.addToCart(item);
    print(item.productModel.title + " sepete eklendi");

    cartStreamController.sink.add(CartService.getCart());
  }

  void removeToCart(Cart item) {
    CartService.removeFromCart(item);
    cartStreamController.sink.add(CartService.getCart());
  }

  List<Cart> getAll() {
    return CartService.getCart();
  }
}

final cartBloc = CartBloc();
