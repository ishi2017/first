import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './direction_repo.dart';
import 'directions_model.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  //Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _cntrl;
  Marker _origin;
  Marker _destination;
  Directions _info;

  @override
  void dispose() {
    _cntrl.dispose();
    super.dispose();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.046830, 75.793567),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
          child: Stack(
            alignment: Alignment.center,
            children: [
              GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (controller) => _cntrl = controller,
                markers: {
                  if (_origin != null) _origin,
                  if (_destination != null) _destination
                },
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: _info.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
                onLongPress: _addMarker,
              ),
              if (_info != null)
                Positioned(
                  top: 20.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: Text(
                      '${_info.totalDistance}, ${_info.totalDuration}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.map,
                  color: Colors.blue,
                ),
                label: Text('Select Location on Map')),
            TextButton.icon(
                onPressed: () {
                  _info != null
                      ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
                      : CameraUpdate.newCameraPosition(_kGooglePlex);
                },
                icon: Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ),
                label: Text('Current Location'))
          ],
        ),
      ],
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        _destination = null;
      });
      _info = null;
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });
      // Get directions
      final directions = await DirectionRepo()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }
}
