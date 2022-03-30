import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/order.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsConts {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
        0,
        Order(
          id: Random().nextDouble().toString(),
          total: cart.totalAmount,
          products: cart.items.values.toList(),
          date: DateTime.now(),
        ));
    notifyListeners();
  }
}