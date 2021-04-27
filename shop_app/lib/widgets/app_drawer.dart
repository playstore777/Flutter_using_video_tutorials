import 'package:flutter/material.dart';

import '../helpers/custom_route.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
            // My Approach for logout!
            // actions: [
            //   Row(
            //     children: <Widget>[
            //       Text('LogOut'),
            //       IconButton(
            //         icon: Icon(Icons.logout),
            //         onPressed: Provider.of<Auth>(context, listen: false).logout, // we don't have any such problem in my approach, as the below approach has!
            //       )
            //     ],
            //   )
            // ],
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (ctx) => OrderScreen(),
                ),
              );
              // Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('LogOut'),
            onTap:
                // Navigator.of(context)
                //     .pop(); // because even after this we logout the drawer stays open and that gives us an error!
                // Navigator.of(context).pushReplacementNamed('/'); // this will remove errors, if any occures while logging out!(kinda optional one, but recommended by max Udemy instructor!)
                Provider.of<Auth>(context, listen: false)
                    .logout, // this approach doesn't throw any error thought(yes this oneline approach is mine ^^)
          )
        ],
      ),
    );
  }
}
