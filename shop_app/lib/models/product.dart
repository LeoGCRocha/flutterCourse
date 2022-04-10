import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final _baseUrl = 'https://shop-6ecbd-default-rtdb.firebaseio.com/products';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();
    await http.patch(
      Uri.parse('$_baseUrl/$id.json'),
      body: jsonEncode(
        {
          "name": name,
          "description": description,
          "price": price,
          "imageUrl": imageUrl,
          "isFavorite": isFavorite
        },
      ),
    );
  }
}
