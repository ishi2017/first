import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetail extends StatelessWidget {
  static final MealDetailRoute = '/meal_detail';
  const MealDetail({Key key}) : super(key: key);

  Widget buidMyContainer(BuildContext context, List<String> myList) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 400,
      height: 200,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 20,
              child: Text(
                '#${(index + 1)}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            title: Text(
              myList[index],
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subtitle: Text('-------------------------------------'),
          );
        },
        itemCount: myList.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealID =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final idMeal = DUMMY_MEALS.firstWhere((meal) => mealID['id'] == meal.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(idMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Image.network(
                idMeal.imageUrl,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Ingredents',
              style: Theme.of(context).textTheme.headline6,
            ),
            Divider(),
            buidMyContainer(context, idMeal.ingredients),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.headline6,
            ),
            Divider(),
            buidMyContainer(context, idMeal.steps),
          ],
        ),
      ),
    );
  }
}
