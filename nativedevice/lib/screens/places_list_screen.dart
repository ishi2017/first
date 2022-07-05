import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fetchAndSetData(),
        builder: (cntx, snap) => snap.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : Consumer<GreatPlaces>(
                child: Center(child: Text('No Place added Yet')),
                builder: (cntx, greatPlace, ch) => greatPlace.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlace.items.length,
                        itemBuilder: (cntx, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    /**Here we use FileImage to Access the image from mobile
                             * filesystem
                             */
                                    FileImage(greatPlace.items[index].image),
                              ),
                              title: Text(greatPlace.items[index].title),
                            ))),
      ),
    );
  }
}
