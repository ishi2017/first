import 'package:flutter/material.dart';
import './Screens/filters_screen.dart';
import './Screens/tabs_screen.dart';
import './Screens/category_meal_screen.dart';
import './Screens/categories_screen.dart';
import './Screens/meal_detail_screen.dart';
import './Models/filters_status.dart';
import './dummy_data.dart';
import './Models/meals.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> availableMeals;
  @override
  void initState() {
    availableMeals = DUMMY_MEALS;
    super.initState();
  }

  final filterStatus currentFilter = filterStatus(
    glutenFree: false,
    lactoseFree: false,
    vegan: false,
    vegetarian: false,
  );

  void saveFilters(filterStatus currentFilter) {
    setState(() {
      availableMeals = DUMMY_MEALS.where((meal) {
        if (currentFilter.glutenFree && !meal.isGlutenFree) {
          return false;
        }
        if (currentFilter.lactoseFree && !meal.isLactoseFree) {
          return false;
        }
        if (currentFilter.vegan && !meal.isVegan) {
          return false;
        }
        if (currentFilter.vegetarian && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

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
        '/': ((context) => TabsScreen()),

        CategoryMealScreen.RouteName: (context) => CategoryMealScreen(
              availableMeal: availableMeals,
            ),
        MealDetail.RouteName: (context) => MealDetail(),
        FiltersScreen.RouteName: ((context) => FiltersScreen(
              currentFilter: currentFilter,
              saveFilter: saveFilters,
            ))
      },
      onGenerateRoute: (setting) {
        return MaterialPageRoute(builder: (context) => TabsScreen());
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
