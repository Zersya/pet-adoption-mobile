import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/map_provider.dart';
import 'package:pet_adoption/screens/map_screen.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  final bool isDetailAddress;

  const MapPage({Key key, this.isDetailAddress = false}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TextEditingController _searchAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (_) => MapProvider(),
      child: Consumer<MapProvider>(builder: (context, value, child) {
        if (value.address.isNotEmpty) _searchAddress.text = value.address[0];

        return Stack(children: [
          MapScreen(),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _searchAddress,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (val) {
                      value.addressToLatLong(address: val, context: context);
                      value.goToMyPos();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.location_on),
                      suffixIcon: _suffixSearch(value),
                      hintText: "Search address",
                    ),
                  ),
                  SizedBox(height: 15),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          child: IconButton(
                            icon: Icon(Icons.location_searching),
                            onPressed: () {
                              value.getPosition(context);
                            },
                          )))
                ],
              ),
            ),
          )
        ]);
      }),
    ));
  }

  Widget _suffixSearch(value) {
    return _searchAddress.value.text.isEmpty
        ? IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              value.addressToLatLong(_searchAddress.value.text, context);
              value.addMarker(context: context);
              value.goToMyPos();
            },
          )
        : IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              value.removeMarker("Your Place", 0);
              _searchAddress.clear();
            });
  }
}
