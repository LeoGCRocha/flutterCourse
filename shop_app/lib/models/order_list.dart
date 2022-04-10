import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/order.dart';
import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsConts {
    return _items.length;
  }

  final _baseUrl = 'https://shop-6ecbd-default-rtdb.firebaseio.com/orders';

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'product': cart.items.values
            .map((cartItem) => {
                  'id': cartItem.id,
                  'name': cartItem.name,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                  'productId': cartItem.productId,
                })
            .toList(),
      }),
    );
    _items.insert(
        0,
        Order(
          id: jsonDecode(response.body)['name'],
          total: cart.totalAmount,
          products: cart.items.values.toList(),
          date: DateTime.now(),
        ));
    notifyListeners();
  }
}
