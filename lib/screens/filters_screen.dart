import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(
      {required this.currentFilters, required this.saveFilters, Key? key})
      : super(key: key);

  static const routeName = "/filters";
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  void initState() {
    _isGlutenFree = widget.currentFilters["gluten-free"]!;
    _isLactoseFree = widget.currentFilters["lactose-free"]!;
    _isVegetarian = widget.currentFilters["is-vegetarian"]!;
    _isVegan = widget.currentFilters["is-vegan"]!;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String subTitle,
    bool value,
    Function(bool) change,
  ) {
    return SwitchListTile(
      value: value,
      title: Text(title),
      subtitle: Text(subTitle),
      onChanged: change,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              Map<String, bool> selectedFilters = {
                "gluten-free": _isGlutenFree,
                "lactose-free": _isLactoseFree,
                "is-vegetarian": _isVegetarian,
                "is-vegan": _isVegan,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10),
            child: Text("Adjust your meal selection.",
                style: Theme.of(context).textTheme.headline6),
          ),
          _buildSwitchListTile(
              "Gluten-Free", "Only include gluten-free meals.", _isGlutenFree,
              (newValue) {
            setState(() {
              _isGlutenFree = newValue;
            });
          }),
          _buildSwitchListTile("Lactose-Free",
              "Only include lactose-free meals.", _isLactoseFree, (newValue) {
            setState(() {
              _isLactoseFree = newValue;
            });
          }),
          _buildSwitchListTile(
              "Vegetarian", "Only include vegetarian meals.", _isVegetarian,
              (newValue) {
            setState(() {
              _isVegetarian = newValue;
            });
          }),
          _buildSwitchListTile("Vegan", "Only include vegan meals.", _isVegan,
              (newValue) {
            setState(() {
              _isVegan = newValue;
            });
          }),
        ],
      ),
    );
  }
}
