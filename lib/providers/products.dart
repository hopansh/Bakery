import 'dart:convert';
import 'dart:io';
import './product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Cake',
    //   description: 'A tooty frooty Cake',
    //   price: 130,
    //   imageUrl: 'https://hopansh.ga/cake.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Pastry',
    //   description: 'A Chocolate pastry',
    //   price: 40,
    //   imageUrl: 'https://hopansh.ga/pastry.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Pizza',
    //   description: 'Hot and spicy: Peper Paneer Pizza with extra cheese',
    //   price: 120,
    //   imageUrl: 'https://hopansh.ga/pizza.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Burger',
    //   description: 'Crispy Aalu Burger',
    //   price: 70,
    //   imageUrl: 'https://hopansh.ga/burger.jpg',
    // ),
  ];
  // var _showFavOnly = false;
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

  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);
  Future<void> addProduct(Product product) async {
    final url =
        'https://bakery-d39d9-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
          }));
      final newproduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        // authToken: authToken,
        id: json.decode(response.body)['name'],
      );
      _items.insert(0, newproduct);
      // _items.add(value);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var url = filterByUser
        ? 'https://bakery-d39d9-default-rtdb.firebaseio.com/products.json?auth=$authToken&orderBy="creatorId"&equalTo="$userId"'
        : 'https://bakery-d39d9-default-rtdb.firebaseio.com/products.json?auth=$authToken';

    try {
      final response = await http.get(url);
      var data = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (data == null) {
        return;
      }
      url =
          'https://bakery-d39d9-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favResponse = await http.get(url);
      final favData = json.decode(favResponse.body);
      data.forEach((prodId, recvData) {
        loadedProducts.insert(
            0,
            Product(
                id: prodId,
                title: recvData['title'],
                description: recvData['description'],
                price: recvData['price'],
                isFavorite: favData == null ? false : favData[prodId] ?? false,
                imageUrl: recvData['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      // throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://bakery-d39d9-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://bakery-d39d9-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final prodInd = _items.indexWhere((element) => element.id == id);
    var existingProd = _items[prodInd];
    _items.removeAt(prodInd);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(prodInd, existingProd);
      notifyListeners();
      throw HttpException("Couldn't delete product");
    }
    existingProd = null;
  }
}
