import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quentity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quentity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quentity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quentity: existingCartItem.quentity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quentity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id){
    _items.remove(id);
    notifyListeners();
  }
  void removeSingleItem(String id){
    if(!_items.containsKey(id)){
      return;
    }
    if(_items[id].quentity >1){
      _items.update(
        id,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quentity: existingCartItem.quentity - 1,
          price: existingCartItem.price,
        ),
      );
    } else{
      _items.remove(id);
    }
    notifyListeners();
  }
  void clear(){
    _items = {};
    notifyListeners();
  }
}
