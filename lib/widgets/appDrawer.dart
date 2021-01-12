import 'package:Bakery/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: Text("Bakery Welcomes you"),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.history),
            title: Text("Orders"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/orders');
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.person),
            title: Text("Your Products"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/admin');
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.call_missed),
            title: Text("Logout"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            })
      ],
    ));
  }
}
