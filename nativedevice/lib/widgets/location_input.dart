import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/location_helper.dart';
import '../screens/add_map_screen.dart';
import '../models/place.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  //Completer<GoogleMapController> _controller = Completer();
  // GoogleMapController _cntrl;
  var _img;
  void _getLoc() async {
    // var loc = Location();
    // var enable = await loc.serviceEnabled();
    // print(enable);
    // if (!enable) {
    //   enable = await loc.requestService();
    //   if (!enable) {
    //     return;
    //   }
    //   var _permission = await loc.hasPermission();
    //   print(_permission);
    //   if (_permission == PermissionStatus.denied) {
    //     _permission = await loc.requestPermission();
    //     if (_permission != PermissionStatus.granted) {
    //       return;
    //     }
    //   }
    // }
    final myloc = await Location().getLocation();
    final imgURL =
        lh.lcpi(latitude: myloc.latitude, longitude: myloc.longitude);
    setState(() {
      _img = imgURL;
    });
  }

  @override
  void dispose() {
    // _cntrl.dispose();
    super.dispose();
  }

  // static final CameraPosition _bsl = CameraPosition(
  //   bearing: 192.8334901395799,
  //   tilt: 59.440717697143555,
  //   target: LatLng(21.046830, 75.793567),
  //   zoom: 14.4746,
  // );
  Future<void> _selectonMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: ((cntx) => (maps(
              initilaPlace: PlaceLocation(
                latitude: 21.0,
                longitude: 75.0,
              ),
              isSelected: true,
            ))),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    print('Selected Location is::======>' + selectedLocation.toString());
    lh.getAddress(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: double.infinity,
            height: 250,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: _img == null
                ? Center(
                    child: Text('No Map'),
                  )
                : Image.network(
                    _img,
                    fit: BoxFit.cover,
                  )
            // child: GoogleMap(
            //   myLocationButtonEnabled: false,
            //   zoomControlsEnabled: false,
            //   initialCameraPosition: _bsl,
            //   onMapCreated: (controller) => _cntrl = controller,
            // ),
            ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton.icon(
                onPressed: _selectonMap,
                icon: Icon(
                  Icons.map,
                  color: Colors.blue,
                ),
                label: Text('Select Location on Map')),
            TextButton.icon(
              onPressed: _getLoc,
              icon: Icon(
                Icons.location_on,
                color: Colors.blue,
              ),
              label: Text('Current Location'),
            ),
          ],
        ),
        TextButton.icon(
            onPressed: () async {},
            icon: Icon(
              Icons.location_on,
              color: Colors.blue,
            ),
            label: Text('Enable Location'))
      ],
    );
  }
}
