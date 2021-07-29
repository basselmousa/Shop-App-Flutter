import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  String authToken;
  String userId;

  getDate(String _authToken, String _userId, List<OrderItem> products) {
    authToken = _authToken;
    userId = _userId;
    _orders = products;
    notifyListeners();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://shop-app-cfe3e-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';

    try {
      final res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<OrderItem> loadedOrders = [];

      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (cartItem) => CartItem(
                    id: cartItem['id'],
                    title: cartItem['title'],
                    quentity: cartItem['quentity'],
                    price: cartItem['price'],
                  ),
                )
                .toList(),
            dateTime: DateTime.parse(orderData['dateTime']),
          ),
        );
      });

      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final timestamp = DateTime.now();
    final url = 'https://shop-app-cfe3e-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final res = await http.post(url, body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProduct.map((cp) => {
          'id': cp.id,
          'title': cp.title,
          'quentity':cp.quentity,
          'price': cp.price
        }).toList(),
      }));
      _orders.insert(0, OrderItem(id: json.decode(res.body)['name'], amount: total, products: cartProduct, dateTime: timestamp));
      notifyListeners();
    }
    catch (err) {
      throw err;
    }
  }


}
