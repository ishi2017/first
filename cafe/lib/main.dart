import 'package:flutter/material.dart';
import './Screens/tabs_screen.dart';
import './Screens/category_meal_screen.dart';
import './Screens/categories_screen.dart';
import './Screens/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        errorColor: Colors.cyan,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'RobotoCondensed',
                color: Colors.red),
            bodyText2: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                color: Colors.purple),
            headline6: TextStyle(
              fontSize: 25,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            )),
      ),
      //home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        // '/': ((context) => const CategoriesScreen()),
        '/': ((context) => const TabsScreen()),

        CategoryMealScreen.CategoryMealScreenArguments: (context) =>
            CategoryMealScreen(),
        MealDetail.MealDetailRoute: (context) => MealDetail(),
      },
      onGenerateRoute: (setting) {
        print(setting.arguments);
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
