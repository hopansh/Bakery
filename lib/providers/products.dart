import './product.dart';
import 'package:flutter/material.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Donuts',
      description: 'A tooty frooty Donut',
      price: 130,
      imageUrl:
          'https://images.pexels.com/photos/3338681/pexels-photo-3338681.jpeg',
    ),
    Product(
      id: 'p2',
      title: 'Pastry',
      description: 'A Chocolate pastry',
      price: 40,
      imageUrl:
          'https://images.pexels.com/photos/1854652/pexels-photo-1854652.jpeg',
    ),
    Product(
      id: 'p3',
      title: 'Pizza',
      description: 'Hot and spicy: Peper Paneer Pizza with extra cheese',
      price: 120,
      imageUrl:
          'https://images.pexels.com/photos/1260968/pexels-photo-1260968.jpeg',
    ),
    Product(
      id: 'p4',
      title: 'Fries',
      description: 'Crispy Aalu fries',
      price: 70,
      imageUrl:
          'https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg',
    ),
  ];
  var _showFavOnly = false;
  List<Product> get items {
    // if (_showFavOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // } else
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((element) => element.isFavorite == true).toList();
  }
  // void ShowFavOnly() {
  //   _showFavOnly = true;
  //   notifyListeners();
  // }

  // void ShowAll() {
  //   _showFavOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((element) => id == element.id);
  }

  void addProduct(Product product) {
    final newproduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: DateTime.now().toString());
    _items.insert(0, newproduct);
    // _items.add(value);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
