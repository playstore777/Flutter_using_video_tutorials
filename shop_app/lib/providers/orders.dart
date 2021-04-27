import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  final authToken;
  final authUserId;
  Orders(this.authToken, this.authUserId, this._orders);
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://flutter-update-edb26-default-rtdb.firebaseio.com/orders/$authUserId.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String,
          dynamic>; // Using Object gives [] isn't defined for the type 'Object' error.
      if (extractedData == null) {
        return;
      }
      // print('extractedData : $extractedData');
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>).map((item) {
              return CartItem(
                id: item['id'],
                price: item['price'],
                quantity: item['quantity'],
                title: item['title'],
              );
            }).toList(),
          ),
        );
        _orders = loadedOrders.reversed.toList();
        notifyListeners();
      });
    } catch (error) {
      print('Error in Orders: $error');
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://flutter-update-edb26-default-rtdb.firebaseio.com/orders/$authUserId.json?auth=$authToken';
    final timeStamp = DateTime
        .now(); //To get the exact same time on server and the local list!
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'dateTime': timeStamp
                .toIso8601String(), //special function, makes conversion easy from string to DateTime!
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
          }));
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timeStamp, // both will have exact same time stamp!
          products: cartProducts,
        ),
      );
      notifyListeners();
    } catch (error) {
      print('Error in orders : $error');
      throw error;
    }
  }
}
