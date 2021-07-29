import 'dart:convert';

import 'package:flutter/foundation.dart';
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

  void _setFavoriteValue(bool favorite){
    isFavorite = favorite;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async{
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url = 'https://shop-app-cfe3e-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try{
        final res = await http.put(url, body: json.encode(isFavorite));
        if(res.statusCode >= 400){
          _setFavoriteValue(oldStatus);
          throw("Cant set this item to favorite now. Try Again Later");
        }
    }
    catch(e){
        _setFavoriteValue(oldStatus);
        throw("Cant set this item to favorite now. Try Again Later");
    }

  }

}
