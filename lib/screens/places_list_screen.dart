import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            )
          ],
        ),
        body: Consumer<GreatPlaces>(
          builder: (BuildContext ctx, GreatPlaces greatPlaces, Widget ch) =>
              greatPlaces.items.length <= 0
                  ? ch
                  : ListView.builder(
                      itemCount: greatPlaces.items.length,
                      itemBuilder: (ctxe, i) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              FileImage(greatPlaces.items[i].image),
                        ),
                        title: Text(greatPlaces.items[i].title),
                        onTap: () {
                          //place detail...
                        },
                      ),
                    ),
          child: Center(
            child: const Text('Got no places yet, start adding some!'),
          ),
        ));
  }
}
