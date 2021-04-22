import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 299.99,
    //   imageUrl:
    //       'https://5.imimg.com/data5/OX/IC/MY-4906124/dsc_3669-500x500.jpg', // this is the image added by me!!
    //   // 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg', // given the Max one of the best Udemy instructor!
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 599.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 199.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 499.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id) =>
      items.firstWhere((product) => product.id == id);

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://flutter-update-edb26-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body)
          as Map<String, dynamic>; // Object instead of dynamic
      // json.decode(response.body) as Map<String, Map<String, Object>>; // this thing here nested map will give error as dart will not understand
      // a nested map so we should use
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: prodData['isFavorite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
      // print(json.decode(response.body));
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://flutter-update-edb26-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(
            {
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'isFavorite': product.isFavorite,
            },
          ));
      print(json.decode(response.body)['name']);
      var newProduct = Product(
        id: json.decode(response.body)['name'],
        description: product.description,
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      // _items.insert(0, new_product);  // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // My Approach for saving isFavorite on the server!(Firebase/Database)
  // Future<void> isFavoriteSave(String id, bool value) async {
  //   final url =
  //       'https://flutter-update-edb26-default-rtdb.firebaseio.com/products/$id.json';
  //   try {
  //     // final currentFavorite
  //     await http.patch(
  //       Uri.parse(url),
  //       body: json.encode(
  //         {
  //           'isFavorite': value,
  //         },
  //       ),
  //     );
  //     final index = _items.indexWhere((prodId) => prodId.id == id);
  //     _items[index].isFavorite = value;
  //     notifyListeners();
  //   } catch (error) {
  //     print('error while changing favorite : $error');
  //   }
  // }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://flutter-update-edb26-default-rtdb.firebaseio.com/products/$id.json'; // using final because here 'id' is dynamic and const doesn't fit well
      await http.patch(
        // need to add Error Handling later by myself!(already did for adding the product but need to do it for updation and other areas)
        Uri.parse(url),
        body: json.encode(
          {
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          },
        ),
      );
      _items[prodIndex] = newProduct;

      notifyListeners();
    } else {
      print('...');
    }
  }

// **this One way of doing this!!**
  // void deleteProduct(String id) {
  //   final url =
  //       'https://flutter-update-edb26-default-rtdb.firebaseio.com/products/$id.json';
  //   final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
  //   var existingProduct = _items[existingProductIndex];
  //   _items.removeWhere((prod) => prod.id == id);
  //   http.delete(Uri.parse(url)).then((response) {
  //     // only in this then block it gets the status code like 200, 300, 400 etc...
  //     // so we can use it to  create our own exception as the default/built doesn't work here.
  //     if (response.statusCode >= 400) {
  //       throw HttpException('Could not delete product.');
  //     }
  //     existingProduct =
  //         null; // if it succeeds then we don't want the data to take any memory.
  //   }).catchError((_) {
  //     // but unfortunately delete doesn't get notified or send any error.
  //     // _items[existingProductIndex] = existingProduct;
  //     _items.insert(existingProductIndex,
  //         existingProduct); // reinserting if any error occured in removing the data from the server. This is called as optimistic updating.
  //   });
  //   notifyListeners();
  // }
  //

// This is another way of doing it!
  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-update-edb26-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    // only in this then block it gets the status code like 200, 300, 400 etc...
    // so we can use it to  create our own exception as the default/built doesn't work here.
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex,
          existingProduct); // reinserting if any error occured in removing the data from the server. This is called as optimistic updating.
      // _items[existingProductIndex] = existingProduct;
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct =
        null; // if it succeeds then we don't want the data to take any memory.

    // but unfortunately delete doesn't get notified or send any error.
  }
}
