import 'dart:io';
import 'package:flutter/material.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File image) {
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: pickedTitle,
      image: image,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
