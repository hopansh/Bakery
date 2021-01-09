import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetails extends StatelessWidget {
  // final String title;
  // ProductDetails(this.title);
  static const routeName = "ProductDetails";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.red,
        backgroundColor: Colors.white,
        splashColor: Colors.redAccent,
        onPressed: () {},
        child: Icon(
            loadedProduct.isFavorite ? Icons.favorite : Icons.favorite_border),
      ),
      body: ListView(
        children: [
          Container(
            height: size.height * 0.4,
            child: Image(
              image: NetworkImage(loadedProduct.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            tileColor: Colors.teal.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            leading: Icon(
              Icons.emoji_food_beverage,
              size: 35,
            ),
            title: Text(
              loadedProduct.title,
              style: TextStyle(
                fontSize: 25,
              ),
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
            subtitle: Text(
              loadedProduct.description,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            trailing: Text(
              "Rs." + loadedProduct.price.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
