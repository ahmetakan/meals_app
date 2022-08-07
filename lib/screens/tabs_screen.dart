import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({required this.favoriteMeals, Key? key}) : super(key: key);
  final List<Meal> favoriteMeals;
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>>? _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        "page": const CategoriesScreen(),
        "title": "Categories",
        "icon": const Icon(Icons.category),
      },
      {
        "page": FavoritesScreen(
          favoriteMeals: widget.favoriteMeals,
        ),
        "title": "Favorites",
        "icon": const Icon(Icons.star),
      }
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages![_selectedPageIndex]["title"]),
      ),
      body: _pages![_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onTap: _selectedPage,
        items: _pages!.map((page) {
          return BottomNavigationBarItem(
            icon: page["icon"],
            label: page["title"],
          );
        }).toList(),
      ),
      drawer: const MainDrawer(),
    );
  }
}
