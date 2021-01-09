import 'package:Bakery/providers/auth.dart';
import 'package:Bakery/providers/orders.dart';
import 'package:Bakery/screens/auth_screen.dart';
import 'package:Bakery/screens/cart_details.dart';
import 'package:Bakery/screens/editingProduct.dart';
import 'package:Bakery/screens/orders_details.dart';
import 'package:Bakery/screens/product_details.dart';
import 'package:Bakery/screens/product_overview.dart';
import 'package:Bakery/screens/userProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(null, []),
            update: (ctx, auth, previousProducts) => Products(auth.token,
                previousProducts.items == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders(null, []),
            update: (ctx, auth, previousOrders) => Orders(auth.token,
                previousOrders == null ? [] : previousOrders.orders),
          ),
          ChangeNotifierProvider.value(value: Cart()),
        ],
        // create: (ctx) => Products(),
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Bakery',
            theme: ThemeData(
              primarySwatch: Colors.teal,
              accentColor: Colors.tealAccent,
              fontFamily: 'Lato',
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetails.routeName: (ctx) => ProductDetails(),
              CartDetails.routeName: (ctx) => CartDetails(),
              OrderDetails.routeName: (ctx) => OrderDetails(),
              UserProduct.routeName: (ctx) => UserProduct(),
              EditProduct.routeName: (ctx) => EditProduct(),
              AuthScreen.routeName: (ctx) => AuthScreen(),
            },
          ),
        ));
  }
}
