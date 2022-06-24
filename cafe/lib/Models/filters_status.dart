import 'package:flutter/cupertino.dart';

class filterStatus {
  bool glutenFree;
  bool vegan;
  bool vegetarian;
  bool lactoseFree;

  filterStatus({
    @required this.glutenFree,
    @required this.lactoseFree,
    @required this.vegan,
    @required this.vegetarian,
  });
}
