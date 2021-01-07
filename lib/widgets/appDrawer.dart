import 'package:flutter/material.dart';

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
            title: Text("Admin"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/admin');
            })
      ],
    ));
  }
}
