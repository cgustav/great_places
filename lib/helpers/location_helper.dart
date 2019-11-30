import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyBCd2hjMJYg_dfJ_01l2EZe5NyGlePJXE4';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&'
        '$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap'
        '&markers=color:red%7Clabel:C%7C$latitude,$longitude'
        '&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(
      {double latitude, double longitude}) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
