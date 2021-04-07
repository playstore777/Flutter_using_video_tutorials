import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoriteScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
          itemCount: favoriteMeals.length,
          itemBuilder: (ctx, index) => MealItem(
                onPressed: () {},
                id: favoriteMeals[index].id,
                affordability: favoriteMeals[index].affordability,
                complexity: favoriteMeals[index].complexity,
                duration: favoriteMeals[index].duration,
                imageUrl: favoriteMeals[index].imageUrl,
                title: favoriteMeals[index].title,
              ));
    }
  }
}
