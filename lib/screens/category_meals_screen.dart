import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  CategoryMealsScreen({required this.availableMeals, Key? key})
      : super(key: key);

  static const routeName = "/category-meals";
  List<Meal> availableMeals;

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryId;
  String? categoryTitle;

  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (_loadedInitData == false) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;

      categoryId = routeArgs["id"];

      categoryTitle = routeArgs["title"];

      widget.availableMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle!,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: widget.availableMeals[index].id,
            title: widget.availableMeals[index].title,
            imageUrl: widget.availableMeals[index].imageUrl,
            duration: widget.availableMeals[index].duration,
            complexity: widget.availableMeals[index].complexity,
            affordability: widget.availableMeals[index].affordability,
          );
        },
        itemCount: widget.availableMeals.length,
      ),
    );
  }
}
