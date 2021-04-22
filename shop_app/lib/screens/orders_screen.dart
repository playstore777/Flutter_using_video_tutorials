import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

// class OrderScreen extends StatefulWidget {
//   static const routeName = '/order-screen';

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   bool _isLoading = false;
//   @override
//   void initState() {
//     _isLoading = true;
//     Future.delayed(Duration(seconds: 0)).then((_) {
//       Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
//         _isLoading = false;
//       });
//     }); // same as Duration.zero check out api.dart
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orderData = Provider.of<Orders>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Orders'),
//       ),
//       drawer: AppDrawer(),
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: orderData.orders.length,
//               itemBuilder: (context, index) =>
//                   OrderItem(orderData.orders[index]),
//             ),
//     );
//   }
// }

// Using FutureBuilders!
class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dataSnapshot.error != null) {
              // error handling stuff here
              return Center(
                child: Text('An error occurred'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (context, index) =>
                      OrderItem(orderData.orders[index]),
                ),
              );
            }
          }),
    );
  }
}



// class OrderScreen extends StatefulWidget {
//   static const routeName = '/order-screen';

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

/*
 if a scenario will rebuild then the following way is better, as in above one, will create new future(futureBuider) everytime it rebuilds,
 so, that will call the fetchAnd.... function more than once, and everything will become mess!
 Here however, we don't need this approach as there is nothing which rebuilds, so, we can go with above approach!
 */
// class _OrderScreenState extends State<OrderScreen> {
//   Future _ordersFuture;

//   Future _obtainOrdersFuture() {
//     return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
//   }

//   @override
//   void initState() {
//     _ordersFuture = _obtainOrdersFuture();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final orderData = Provider.of<Orders>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Orders'),
//       ),
//       drawer: AppDrawer(),
//       body: FutureBuilder(
//           future: _ordersFuture,
//           builder: (ctx, dataSnapshot) {
//             if (dataSnapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (dataSnapshot.error != null) {
//               // error handling stuff here
//               return Center(
//                 child: Text('An error occurred'),
//               );
//             } else {
//               return Consumer<Orders>(
//                 builder: (ctx, orderData, child) => ListView.builder(
//                   itemCount: orderData.orders.length,
//                   itemBuilder: (context, index) =>
//                       OrderItem(orderData.orders[index]),
//                 ),
//               );
//             }
//           }),
//     );
//   }
// }
