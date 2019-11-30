import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_detail_screen.dart';
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
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
                  builder: (BuildContext ctx, GreatPlaces greatPlaces,
                          Widget ch) =>
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
                                subtitle:
                                    Text(greatPlaces.items[i].location.address),
                                onTap: () {
                                  //place detail...
                                  Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: greatPlaces.items[i].id,
                                  );
                                },
                              ),
                            ),
                  child: Center(
                    child: const Text('Got no places yet, start adding some!'),
                  ),
                ),
        ));
  }
}
