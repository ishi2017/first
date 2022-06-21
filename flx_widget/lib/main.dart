import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexible Widget Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flexible Widegt Demo'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              height: 300,
              width: 20,
              color: Colors.amber,
            ),
          ),
          Expanded(
            flex: 4,
            //fit: FlexFit.tight,
            child: Container(
              height: 300,
              width: 20,
              color: Colors.purple,
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Container(
              height: 300,
              width: 20,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
