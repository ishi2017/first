import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Padding> myBox = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        key: const ValueKey(0),
        height: 100,
        width: 100,
        color: Colors.green,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        key: const ValueKey(0),
        height: 100,
        width: 100,
        color: Colors.blue,
      ),
    ),
  ];

  void swap() {
    setState(() {
      myBox.insert(1, myBox.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keys Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Keys Demo'),
        ),
        body: Row(
          children: myBox,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: swap, child: const Icon(Icons.sentiment_satisfied)),
      ),
    );
  }
}
