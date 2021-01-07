import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int price;
  final int quantity;
  CartItem(this.id, this.productId, this.title, this.quantity, this.price);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) {
        if (DismissDirection.endToStart == direction) {
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        } else {
          Provider.of<Cart>(context, listen: false).removeSingleItem(productId);
        }
      },
      background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete_sweep,
            color: Colors.white,
            size: 35,
          )),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Provider.of<Cart>(context, listen: false)
                  .addItem(productId, price, title);
            }),
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          "Quantity: x" + quantity.toString(),
          style: TextStyle(fontSize: 15),
        ),
        trailing: Text(
          "Rs. " + (price * quantity).toString(),
          style: TextStyle(fontSize: 15),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are your sure?"),
                  content: Text("All quantity of this item will be removed"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text("No")),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text("Yes")),
                  ],
                ));
      },
    );
  }
}
