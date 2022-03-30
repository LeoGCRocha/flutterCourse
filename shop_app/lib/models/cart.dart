import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    /* Retornar um clone para classes de fora não consigam fazer alteração neste atributo. Caso retorne direto _item seria uma referência. */
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void limparCarrinho() {
    _items = {};
    notifyListeners();
  }

  void addItem(Product prod) {
    if (_items.containsKey(prod.id)) {
      _items.update(
          prod.id,
          (existingItem) => CartItem(
                id: existingItem.id,
                productId: existingItem.id,
                name: existingItem.name,
                quantity: existingItem.quantity + 1,
                price: existingItem.price,
              ));
    } else {
      _items.putIfAbsent(
          prod.id,
          () => CartItem(
              id: Random().nextDouble().toString(),
              productId: prod.id,
              name: prod.name,
              quantity: 1,
              price: prod.price));
    }
    notifyListeners();
  }
}
