import 'dart:math';
import 'package:Bakery/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersTile extends StatefulWidget {
  final OrderItem order;
  OrdersTile(this.order);

  @override
  _OrdersTileState createState() => _OrdersTileState();
}

class _OrdersTileState extends State<OrdersTile> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          ListTile(
            title: Text("Rs.${widget.order.amount}"),
            subtitle: Text(
                DateFormat('dd/MM/yyyy  hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 100, 180),
              child: ListView(
                children: widget.order.products
                    .map((prod) => (ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        leading: Text(
                          prod.quantity.toString() + "x",
                          style: TextStyle(fontSize: 15),
                        ),
                        title: Text(
                          prod.title,
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: Text(
                          "Rs. " + (prod.price * prod.quantity).toString(),
                          style: TextStyle(fontSize: 15),
                        ))))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
