import 'package:flutter/material.dart';
import '../Models/meals.dart';
import '../Screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem(
      {Key key,
      @required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.duration,
      @required this.complexity,
      @required this.affordability})
      : super(key: key);

  String get ComplexityInfo {
    switch (complexity) {
      case Complexity.Simple:
        {
          return 'Simple';
        }
      case Complexity.Hard:
        {
          return 'Hard';
        }
      case Complexity.Challenging:
        {
          return 'Challenging';
        }
      default:
        {
          return 'Unknown';
        }
    }
  }

  String get AffordabilityInfo {
    switch (affordability) {
      case Affordability.Affordable:
        {
          return 'Affordable';
        }
      case Affordability.Pricey:
        {
          return 'Pricey';
        }
      case Affordability.Luxurious:
        {
          return 'Luxurios';
        }
      default:
        {
          return 'Unknown';
        }
    }
  }

  void goToMealDetail(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetail.MealDetailRoute, arguments: {'id': id});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToMealDetail(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    //width: 300,
                    padding: EdgeInsets.all(10),
                    color: Colors.black54,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.right,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(width: 5.0),
                      Text('$duration')
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(width: 5.0),
                      Text(ComplexityInfo),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.currency_rupee),
                      SizedBox(width: 5.0),
                      Text(AffordabilityInfo)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
