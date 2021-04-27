import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  // Max(Udemy instructors) approach is in writing the code in this function, and my approach is in products.dart!(ofcourse commented out!)
  Future<void> toggleFavoriteStatus(authToken, authUserId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://flutter-update-edb26-default-rtdb.firebaseio.com/userFavorites/$authUserId/$id.json?auth=$authToken';
    try {
      final response = await http.put(
          Uri.parse(
              url), // http for patch, put and delete doesn't notify/send any error message, so, we have to use StatsCode again.
          body: json.encode(isFavorite));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
