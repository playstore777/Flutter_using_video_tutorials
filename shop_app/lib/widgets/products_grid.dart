import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'product_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(
        context); // we can also directly use (context).items, instead of taking it to another var or step!

    final products =
        (showFavs) ? productsData.favoriteItems : productsData.items;
    return Scrollable(
      viewportBuilder: (context, position) => GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        // (products.length != null) ? products.length : 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 /
              2, // 3 times height and 2 times width or say height should be greater than width
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // whenever we replace the screen or abandon this widget
          // the changeN....value  also removes the data from the memory
          // as the flutter removes the widget for efficiency.
          value: products[i],
          child: ProductItem(),
        ),
      ),
    );
  }
}
