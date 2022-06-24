import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/main.dart';
import '../Models/meals.dart';
import '../Screens/meal_detail_screen.dart';

class MealItem extends StatefulWidget {
  final Function removeFromList;
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Meal completeMealElement;

  const MealItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.removeFromList,
    @required this.completeMealElement,
  }) : super(key: key);

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  bool isFavourite;
  @override
  void initState() {
    if (MyApp.favMeal.contains(widget.completeMealElement)) {
      isFavourite = true;
    } else {
      isFavourite = false;
    }
    super.initState();
  }

  String get ComplexityInfo {
    switch (widget.complexity) {
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
    switch (widget.affordability) {
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
    Navigator.of(context).pushNamed(MealDetail.RouteName,
        arguments: {'id': widget.id}).then((selectedMealId) {
      widget.removeFromList(selectedMealId);
    });
  }

  void changeState(String id) {
    setState(() {
      if (isFavourite) {
        MyApp.favMeal.remove(widget.completeMealElement);
        isFavourite = false;
      } else {
        MyApp.favMeal.add(widget.completeMealElement);
        isFavourite = true;
      }
    });
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
                    widget.imageUrl,
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
                      widget.title,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () => changeState(widget.id),
                    splashColor: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    child: isFavourite
                        ? Icon(
                            Icons.star,
                            size: 50,
                            color: Colors.amber,
                          )
                        : Icon(
                            Icons.star_border_outlined,
                            size: 50,
                            color: Colors.purple,
                          ),
                  ),
                ),
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
                      Text('${widget.duration}')
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
