import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme:
            ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.amber),
        //home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (BuildContext ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (BuildContext ctx) =>
              PlaceDetailScreen(),
        },
      ),
    );
  }
}
