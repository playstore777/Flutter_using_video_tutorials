import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals-screen';
  // final String categoryId;
  // final String categoryTitle;
  // CategoryMealsScreen(this.categoryId, this.categoryTitle);
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS
        .where(
          (meal) => meal.categories.contains(categoryId),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) => MealItem(
                id: categoryMeals[index].id,
                affordability: categoryMeals[index].affordability,
                complexity: categoryMeals[index].complexity,
                duration: categoryMeals[index].duration,
                imageUrl: categoryMeals[index].imageUrl,
                title: categoryMeals[index].title,
              )),
    );
  }
}
