import 'package:flutter/foundation.dart';
import 'package:great_places/models/place.dart';
import 'dart:io';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => List.from(_items);

  addPlace({String pickedTitle, File pickedImage}) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        image: pickedImage,
        location: null);

    _items.add(newPlace);
    notifyListeners();
  }
}
