import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

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
    // final productsContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: Text('My Shop'), actions: <Widget>[
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
        )
      ]),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
