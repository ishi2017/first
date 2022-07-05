import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _setImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveImage() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_pickedImage, _titleController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_setImage),
                    SizedBox(
                      height: 20,
                    ),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: () {
              _saveImage();
            },
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            /**It will not allow any loose space below button */
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
