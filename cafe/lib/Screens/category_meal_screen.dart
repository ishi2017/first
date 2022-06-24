import 'package:flutter/material.dart';

import '../Widgets/meal_Item.dart';
import '../dummy_data.dart';
import '../Models/meals.dart';

class CategoryMealScreen extends StatefulWidget {
  static final String RouteName = '/Category_Meal';

  final List<Meal> availableMeal;

  CategoryMealScreen({this.availableMeal});

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  bool isInitStateDone = false;
  List<Meal> displayedMeal;
  String title;
  Color color;

  @override
  void didChangeDependencies() {
    if (!isInitStateDone) {
      final ModalArg =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      color = ModalArg['color'] as Color;
      title = ModalArg['title'] as String;
      final id = ModalArg['id'];
      displayedMeal = widget.availableMeal.where((meal) {
        return meal.categories.contains(id);
      }).toList();
    }
    isInitStateDone = true;
    super.didChangeDependencies();
  }

  void RemoveFromList(String id) {
    setState(() {
      displayedMeal.removeWhere((meal) => meal.id == id);
      print('Executed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: displayedMeal.elementAt(index).id,
            title: displayedMeal.elementAt(index).title,
            imageUrl: displayedMeal.elementAt(index).imageUrl,
            duration: displayedMeal.elementAt(index).duration,
            complexity: displayedMeal.elementAt(index).complexity,
            affordability: displayedMeal.elementAt(index).affordability,
            removeFromList: RemoveFromList,
          );
        },
        itemCount: displayedMeal.length,
      ),
    );
  }
}
