import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place.dart';
import 'dart:io';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => List.from(_items);

  Place findById({@required id}) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> addPlace(
      {String pickedTitle,
      File pickedImage,
      PlaceLocation pickedLocation}) async {
    //

    final address = await LocationHelper.getPlaceAddress(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
    );

    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );

    //storing in memory
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: updatedLocation,
    );

    //storing in local db
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(table: 'user_places', data: {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dbList = await DBHelper.fetch(table: 'user_places');

    dbList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            )))
        .toList();

    notifyListeners();
  }
}
