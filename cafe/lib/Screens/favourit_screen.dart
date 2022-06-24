import 'package:flutter/material.dart';
import '../Screens/category_meal_screen.dart';
import '../Models/meals.dart';

class FavouritScreen extends StatelessWidget {
  static final String RouteName = '/FavScreen';
  final List<Meal> favMeal;
  const FavouritScreen({Key key, this.favMeal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryMealScreen(
      availableMeal: favMeal,
      isFavCase: true,
    );
  }
}
