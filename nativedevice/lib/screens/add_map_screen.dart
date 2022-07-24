import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class maps extends StatefulWidget {
  final PlaceLocation initilaPlace;
  final bool isSelected;
  const maps({Key key, this.initilaPlace, this.isSelected}) : super(key: key);

  @override
  State<maps> createState() => _mapsState();
}

class _mapsState extends State<maps> {
  LatLng _picked;
  void _selectPlace(LatLng pos) {
    setState(() {
      _picked = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select on Map'),
        actions: <Widget>[
          if (widget.isSelected)
            IconButton(
              icon: Icon(Icons.check),
              color: Colors.blue,
              onPressed: _picked == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_picked);
                    },
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initilaPlace.latitude,
            widget.initilaPlace.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelected ? (pos) => _selectPlace(pos) : null,
        markers: _picked == null
            ? ({})
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _picked,
                ),
              },
      ),
    );
  }
}
