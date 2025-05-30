import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite, //169 recibe func de meals_details.dart para ejecutar en tabs.dart
  });

  final String? title; //  sign ? added 168 15:12
  final List<Meal> meals; //160
  final void Function(Meal meal) onToggleFavorite; //guarda func

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (cnx) => MealsDetailsScreen(
              meal: meal,
              onToggleFavorite: onToggleFavorite, //func passing
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uh oh .. nothing here",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "try selecting a different category",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length, //161      166 onSelectMeal
        itemBuilder:
            (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (context, meal) {
                selectMeal(context, meal);
              },
            ),
      );
    }

    if (title == null) {
      return content;
    } //168 15:15 created to solve the double Scaffold(appBar)

    return Scaffold(appBar: AppBar(title: Text(title!)), body: content);
  }

  //if called from tabs.dart no traera title entonces= no render appBar, if called from
}
