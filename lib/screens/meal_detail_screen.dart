import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(
      {required this.isFavorite, required this.toggleFavorite, Key? key})
      : super(key: key);

  static const routeName = "/meal-detail";
  final Function toggleFavorite;
  final Function isFavorite;
  Widget buildSectionTitle(BuildContext ctx, String title) {
    return Text(
      title,
      style: Theme.of(ctx).textTheme.headline6,
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      height: 100,
      width: 300,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          style: BorderStyle.solid,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${selectedMeal.title} Detail",
          style: const TextStyle(fontSize: 17),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(ListView.builder(
              itemBuilder: ((ctx, index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(selectedMeal.ingredients[index]),
                );
              }),
              itemCount: selectedMeal.ingredients.length,
            )),
            buildSectionTitle(context, "Steps"),
            buildContainer(ListView.builder(
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text("#${index + 1}"),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    const Divider(),
                  ],
                );
              }),
              itemCount: selectedMeal.steps.length,
            )),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: FloatingActionButton(
                child: Icon(
                  isFavorite(mealId) ? Icons.star : Icons.star_border,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  toggleFavorite(mealId);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
