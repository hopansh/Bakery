import 'package:Bakery/widgets/appDrawer.dart';
import 'package:Bakery/widgets/ordersTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

class OrderDetails extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
            itemCount: orderData.orders.length,
            itemBuilder: (ctx, i) => OrdersTile(orderData.orders[i])));
  }
}
