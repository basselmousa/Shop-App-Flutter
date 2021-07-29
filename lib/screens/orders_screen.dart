import 'package:flutter/material.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_item.dart';
import 'package:shop_app/providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const String ordersRouteName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapShot.error != null) {
              return Center(
                child: Text("An error Occurred"),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, index)=>OrderItem(orderData.orders[index]),
                ),
              );
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
