import 'package:flutter/material.dart';
import '../dummy_data.dart';
import './category_meal_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Meals'),
      ),
      body: GridView(
        children: List.generate(DUMMY_CATEGORIES.length, (index) {
          return InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (c) {
              //       return CategoryMealScreen(
              //         id: DUMMY_CATEGORIES[index].id,
              //         categoryTitle: DUMMY_CATEGORIES[index].title,
              //         color: DUMMY_CATEGORIES[index].color,
              //       );
              //     },
              //   ),
              // );

              Navigator.of(context).pushNamed(
                  CategoryMealScreen.CategoryMealScreenArguments,
                  arguments: {
                    'id': DUMMY_CATEGORIES[index].id,
                    'title': DUMMY_CATEGORIES[index].title,
                    'color': DUMMY_CATEGORIES[index].color,
                  });
            },
            splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    DUMMY_CATEGORIES[index].color.withOpacity(0.3),
                    // Colors.white, Colors.red, Colors.blue,
                    DUMMY_CATEGORIES[index].color
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Text(
                DUMMY_CATEGORIES[index].title,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
