// tabs.dart is the main DATA MANAGEMENT WIDGET loads the all meals screen,

import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    //required this.onToggleFavorite, removed by Provider()
    required this.avaliableMeals,
  }); //

  //final void Function(Meal meal) onToggleFavorite; r by Provider()

  final List<Meal> avaliableMeals; //179

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals =
        avaliableMeals //dummyMeals to avaliableMeals 179
            .where((meal) => meal.categories.contains(category.id))
            .toList(); //163

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
              //onToggleFavorite: onToggleFavorite, r by Provider()
              //onToggleFavorite func triggered in MealsDetails, managed in TabsScreen, passes through MealsScreen
            ),
      ),
    ); // Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        //avaliableCategories.map((category)=> CategoryGridItem(category: category)).toLis() alternative to the FOR loop
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
      //GridView 156
    );
  }
}
