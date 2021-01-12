import 'package:Bakery/providers/auth.dart';
import 'package:Bakery/providers/cart.dart';
import 'package:Bakery/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetails.routeName, arguments: product.id);
            },
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                placeholder: AssetImage("assets/images/food.gif"),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          footer: Consumer<Product>(
            builder: (ctx, product, child) => GridTileBar(
                backgroundColor: Colors.black87,
                leading: IconButton(
                  icon: product.isFavorite
                      ? Icon(
                          Icons.favorite,
                          color: Colors.orange,
                        )
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    product.toggleFavStatus(authData.token, authData.userId);
                  },
                ),
                title: Text(
                  product.title,
                  textAlign: TextAlign.left,
                ),
                subtitle: Text("Rs." + product.price.toString()),
                trailing: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    cart.addItem(product.id, product.price, product.title);
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Added to cart"),
                      duration: Duration(seconds: 3),
                      action: SnackBarAction(
                        label: "UNDO",
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        },
                      ),
                    ));
                  },
                )),
          )),
    );
  }
}
