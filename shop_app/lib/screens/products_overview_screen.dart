import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/app_drawer.dart';

import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  // productsContainer.showFavoritesOnly();
                  _showOnlyFavorites = true;
                } else {
                  // productsContainer.showAll();
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Only Favorite'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            // consumer is a generic type so, it is necessary/important to provide the type.
            builder: (_, cart, ch) => Badge(
              // what we do is or say did is, to increase performance or not rebuild icon everytime the value changes
              // which is waste, So, we pushed the child of badge out into consumer and consumer doesn't change it but still provide it to the Badge
              child: ch,
              value: (cart.itemCount).toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.rountName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
