import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:location/location.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  // AppPlaceScreen({Key key}) : super(key: key);
  static const String routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  TextEditingController _titleController;
  File _pickedImage;
  PlaceLocation _pickedLocation;

  @override
  void initState() {
    _titleController = TextEditingController(text: '');

    // TODO: implement initState
    super.initState();
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) return;
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
        pickedTitle: _titleController.text,
        pickedImage: _pickedImage,
        pickedLocation: _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //Form(),
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
                  ImageInput(
                    onSelectImage: _selectImage,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LocationInput(
                    onSelectPlace: _selectPlace,
                  ),
                  // TextField(),
                  // TextField(),
                ],
              ),
            ),
          )),
          RaisedButton.icon(
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            color: Theme.of(context).accentColor,
            onPressed: _savePlace,
          )
        ],
      ),
      //child: ,
    );
  }
}
