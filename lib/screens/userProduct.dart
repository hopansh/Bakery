import 'package:Bakery/widgets/adminItem.dart';
import 'package:Bakery/widgets/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProduct extends StatelessWidget {
  static const routeName = "/admin";
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin"),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed('/editProduct');
                })
          ],
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: ListView.builder(
                itemCount: productData.items.length,
                itemBuilder: (_, i) => Column(children: [
                      AdminItem(
                          productData.items[i].id,
                          productData.items[i].title,
                          productData.items[i].imageUrl),
                      Divider(),
                    ])),
          ),
        ));
  }
}
