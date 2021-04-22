import 'package:flutter/material.dart';

import '../providers/cart.dart';

import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id, title, productId;
  final double price;
  final int quantity;
  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the item from the cart?'),
            actions: [
              TextButton(
                child: Text('Yes'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(key),
      background: Container(
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Theme.of(context).errorColor,
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Container(
      //       child: Icon(
      //         Icons.delete,
      //         color: Colors.white,
      //         size: 40,
      //       ),
      //       alignment: Alignment.centerRight,
      //       padding: const EdgeInsets.only(right: 20),
      //     ),
      //     Container(
      //       child: Icon(
      //         Icons.delete,
      //         color: Colors.white,
      //         size: 40,
      //       ),
      //       alignment: Alignment.centerLeft,
      //       padding: const EdgeInsets.only(right: 20),
      //     ),
      //   ],
      // ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('₹$price')),
            ),
            title: Text(title),
            subtitle: Text('Total: ₹${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
