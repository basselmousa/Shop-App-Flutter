import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem orderItem;

  OrderItem(this.orderItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ExpansionTile(
        title: Text("\$${orderItem.amount}"),
        subtitle:
            Text(DateFormat('dd/MM/yyyy hh:mm').format(orderItem.dateTime)),
        children: orderItem.products
            .map(
              (prod) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    prod.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${prod.quentity}x \$${prod.price}',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
