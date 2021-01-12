import 'package:Bakery/screens/orders_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cartItemTile.dart';
import '../providers/orders.dart';

class CartDetails extends StatelessWidget {
  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].price,
              ),
            ),
          ),
          ListTile(
            tileColor: Colors.teal.withOpacity(0.1),
            leading: Icon(Icons.shopping_bag),
            title: Text("Total",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            trailing: Text("Rs." + cart.totalAmount.toStringAsFixed(2),
                style: TextStyle(fontSize: 20)),
          ),
          OrderButton(cart: cart),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      tileColor: Colors.teal.withOpacity(0.1),
      trailing: _isLoading
          ? CircularProgressIndicator()
          : ActionChip(
              elevation: 5,
              padding: EdgeInsets.all(10),
              label: Text("Place Order",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              backgroundColor: Colors.orange,
              onPressed: (widget.cart.totalAmount <= 0 || _isLoading == true)
                  ? () {}
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await Provider.of<Orders>(context, listen: false)
                          .addOrder(widget.cart.items.values.toList(),
                              widget.cart.totalAmount);
                      setState(() {
                        _isLoading = false;
                      });
                      widget.cart.clear();
                      Navigator.of(context)
                          .pushReplacementNamed(OrderDetails.routeName);
                    },
            ),
    );
  }
}
