import 'package:flutter/material.dart';

class CategoryMealScreen extends StatelessWidget {
  final String id;
  final String categoryTitle;
  final Color color;
  const CategoryMealScreen({Key key, this.id, this.categoryTitle, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: color,
      ),
      body: Center(
        child: Text('Page under Construction'),
      ),
    );
  }
}
