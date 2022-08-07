import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

Map<String, bool> _filters = {
  "gluten-free": false,
  "lactose-free": false,
  "is-vegetarian": false,
  "is-vegan": false
};

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;

  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    bool existOrNot = _favoriteMeals.any((meal) {
      return meal.id == mealId;
    });

    if (existOrNot == true) {
      setState(() {
        _favoriteMeals.removeWhere((meal) {
          return meal.id == mealId;
        });
      });
    } else {
      setState(() {
        Meal willAddToFavoriteMeal = DUMMY_MEALS.firstWhere((meal) {
          return meal.id == mealId;
        });
        _favoriteMeals.add(willAddToFavoriteMeal);
      });
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters["gluten-free"]! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters["lactose-free"]! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters["is-vegetarian"]! && !meal.isVegetarian) {
          return false;
        }
        if (_filters["is-vegan"]! && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) {
      return meal.id == mealId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.pink,
          secondary: Colors.amber,
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              titleTextStyle: const TextStyle(
                fontFamily: "Raleway",
              ),
            ),
      ),
      initialRoute: "/",
      routes: {
        CategoryMealsScreen.routeName: (ctx) {
          return CategoryMealsScreen(
            availableMeals: _availableMeals,
          );
        },
        "/": (ctx) {
          return TabsScreen(
            favoriteMeals: _favoriteMeals,
          );
        },
        MealDetailScreen.routeName: (ctx) {
          return MealDetailScreen(
            toggleFavorite: _toggleFavorite,
            isFavorite: _isMealFavorite,
          );
        },
        FiltersScreen.routeName: (ctx) {
          return FiltersScreen(
            saveFilters: _setFilters,
            currentFilters: _filters,
          );
        },
      },
    );
  }
}
