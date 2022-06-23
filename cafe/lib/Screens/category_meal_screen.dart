import 'package:flutter/material.dart';
import '../Widgets/meal_Item.dart';
import '../dummy_data.dart';
import '../Models/meals.dart';

class CategoryMealScreen extends StatelessWidget {
  static final String CategoryMealScreenArguments = '/Category_Meal';

  @override
  Widget build(BuildContext context) {
    final ModalArg =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final catogisedMeal = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(ModalArg['id']);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(ModalArg['title'] as String),
        backgroundColor: ModalArg['color'] as Color,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
              id: catogisedMeal.elementAt(index).id,
              title: catogisedMeal.elementAt(index).title,
              imageUrl: catogisedMeal.elementAt(index).imageUrl,
              duration: catogisedMeal.elementAt(index).duration,
              complexity: catogisedMeal.elementAt(index).complexity,
              affordability: catogisedMeal.elementAt(index).affordability);
        },
        itemCount: catogisedMeal.length,
      ),
    );
  }
}
