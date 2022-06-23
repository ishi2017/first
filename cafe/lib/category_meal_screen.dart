import 'package:flutter/material.dart';

class CategoryMealScreen extends StatelessWidget {
  // final String id;
  // final String categoryTitle;
  // final Color color;
  // const CategoryMealScreen({Key key, this.id, this.categoryTitle, this.color})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModalArg =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    return Scaffold(
      appBar: AppBar(
        title: Text(ModalArg['title'] as String),
        backgroundColor: ModalArg['color'] as Color,
      ),
      body: Center(
        child: Text(
            'Page with ID:${ModalArg['id'] as String} is under Construction'),
      ),
    );
  }
}
