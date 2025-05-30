// tabs.dart is the main DATA MANAGEMENT WIDGET loads the all meals screen,
import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitalFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
}; //179 Map from filters.dart

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key}); //168

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0; //168 6:57
  final List<Meal> _favoriteMeals = [];
  //169 [] to recieve List from MealsScreen
  Map<Filter, bool> _selectedFilters =
      kInitalFilters; //179 Map from filters.dart

  //170 5:00 func to display _showInfoMessage msg as SnackBar
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  //169 3:59 func manager
  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal); //true or false

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal); //170 setState to trigger removal inmediat
      });
      _showInfoMessage("Meal no longer a favorite."); //170
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("marked as favorite!"); //170
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //172 < MainDrawer(onSelectScreen string)
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); //close drawer so when back wont be drawr open
    if (identifier == "filters") {
      //178 <Map<Filter, bool>> value comes from filters.dart PopScope
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ), //174
        //179 15:14 _selectedFilters
      );
      setState(() {
        _selectedFilters =
            result ?? kInitalFilters; //179 use k as fallback value
      });
    }
  } //push:stacks so adds back butt, pushReplacement:replaces so no back butt

  @override
  Widget build(BuildContext context) {
    final avaliableMeals = //179
        dummyMeals.where((meal) {
          if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      avaliableMeals: avaliableMeals, //179
    ); //use func as value

    var activePageTitle = "categories";

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        //favoriteMeals empty list at first, if star is selected the meal is sent to MealsScreen
        onToggleFavorite: _toggleMealFavoriteStatus, //func manager
      );
      activePageTitle = "Favorites";
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
