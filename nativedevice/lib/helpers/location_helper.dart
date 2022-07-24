import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = "AIzaSyCLG8PqIqYZ8k0s0ZI8SQ30iXuvSrRbCKI";
const SG = 't2tbThySR9_8MP4bdypq8FWC9XQ=';

class lh {
  static String lcpi({double latitude, double longitude}) {
    //  return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&key=$GOOGLE_API_KEY&signature=$SG';

    return 'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
    final responce = await http.get(url);
    print(json.decode(responce.body));
  }
}
