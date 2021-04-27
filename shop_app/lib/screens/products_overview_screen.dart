import 'package:flutter/material.dart';

import 'cart_screen.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

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
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    //maybe there is some issue with this below, alternative of(or for the) didChangeD... code!
    //   _isLoading = true;
    //   // Provider.of<Products>(context).fetchAndSetProducts(); // we get error if we use this, because anything related to context doesn't work
    //   Future.delayed(Duration.zero).then((_) {
    //     Provider.of<Products>(context, listen: false).fetchAndSetProducts();
    //   }).then((_) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   }); // now this, code here future all it does is pushes this code to the last and it will be done after all the sync code is completed, because
    //   // dart doesn't care for the time it takes for code to complete rather, it simply pushes all future codes to complete after sync!
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
