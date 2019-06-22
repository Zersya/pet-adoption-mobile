import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_adoption/providers/map_provider.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  void initState() {
    final _mapProvider = Provider.of<MapProvider>(context, listen: false);
    _mapProvider.checkingGPSActive();
    _mapProvider.getPosition(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _mapProvider = Provider.of<MapProvider>(context);

    if(!_mapProvider.isGpsActive)
      return Center(child:Text("GPS is Not Active"));

    if(_mapProvider.positionNow == null)
      return Center(child: CircularProgressIndicator());

    return GoogleMap(
        markers: Set<Marker>.of(_mapProvider.markers.values),
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(_mapProvider.positionNow.latitude, _mapProvider.positionNow.longitude),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapProvider.controller.complete(controller);
        });
  }

}
