import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: Consumer<GreatPlaces>(
          child: Center(
            child: Text('Got no places yet, start adding some!'),
          ),
          builder: (ctx, greatPlaces, child) => greatPlaces.items.length <= 0
              // greatPlaces.items.isEmpty // My approach!
              ? child
              : ListView.builder(
                  itemBuilder: (ctx, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        greatPlaces.items[index].image,
                      ),
                    ),
                    title: Text(
                      greatPlaces.items[index].title,
                    ),
                    onTap: () {
                      // Go to detail page ..
                    },
                  ),
                  itemCount: greatPlaces.items.length,
                ),
        ));
  }
}
