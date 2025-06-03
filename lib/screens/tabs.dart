// tabs.dart is the main DATA MANAGEMENT WIDGET loads the all meals screen,
import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/favorites_provider.dart';

const kInitalFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
}; //179 Map from filters.dart

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key}); //168

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0; //168 6:57
  //final List<Meal> _favoriteMeals = []; replaced by favorites_provider.dart

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //172 < MainDrawer(onSelectScreen string)
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); //close drawer so when back wont be drawr open
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => FiltersScreen()), //174
        //179 15:14 _selectedFilters
      );
    }
  } //push:stacks so adds back butt, pushReplacement:replaces so no back butt

  @override
  Widget build(BuildContext context) {
    final avaliableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      //onToggleFavorite: _toggleMealFavoriteStatus,---removed by provider()
      avaliableMeals: avaliableMeals, //179
    ); //use func as value

    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider); //189
      activePage = MealsScreen(
        meals: favoriteMeals, // _favoriteMeals
        //favoriteMeals empty list at first, if star is selected the meal is sent to MealsScreen
        //onToggleFavorite: _toggleMealFavoriteStatus,---removed by provider()
      );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      //drawer: MainDrawer() ListTile onTap changes the screen
      drawer: MainDrawer(onSelectScreen: _setScreen), //172 < MainDrawer
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
