import 'package:flutter/material.dart';
import 'package:shop_app/data/dummy_data.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  void saveProduct(Product p, int index) {
    _items[index] = p;
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }
}
