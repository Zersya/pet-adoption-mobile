import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier {
  Position _positionNow;
  Position get positionNow => _positionNow;

  bool _isGpsActive = false;
  bool get isGpsActive => _isGpsActive;

  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Map<MarkerId, Marker> get markers => _markers;

  List<Placemark> _placemark;
  List<Placemark> get placemark => _placemark;

  List<String> _address = new List();
  List<String> get address => _address;

  Completer<GoogleMapController> _controller = Completer();
  Completer<GoogleMapController> get controller => _controller;

  CameraPosition _cameraPosition;
  CameraPosition get cameraPosition => _cameraPosition;

  void getPosition(context) async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    _positionNow = position;
    addMarker(context: context);
    latLongToAddress();
    notifyListeners();
  }

  void checkingGPSActive() async {
    _isGpsActive = await Geolocator().isLocationServiceEnabled();
    notifyListeners();
  }

  void latLongToAddress() async {
    _placemark = await Geolocator()
        .placemarkFromCoordinates(positionNow.latitude, positionNow.longitude);
    placeMarkToAddress();
    notifyListeners();
  }

  void addressToLatLong({String address, context}) async {
    _placemark = await Geolocator().placemarkFromAddress(address);
    _positionNow = _placemark[0].position;
    addMarker(context: context);
    placeMarkToAddress();
    notifyListeners();
  }

  void addMarker({String id = "Your Place", context}) {
    final MarkerId markerId = MarkerId(id);

    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(positionNow.latitude, positionNow.longitude),
        infoWindow: InfoWindow(title: markerId.value, snippet: '*'),
        onTap: () {
          Navigator.of(context).pop([
            _placemark[0].subLocality +
                ", " +
                _placemark[0].subAdministrativeArea,
            _placemark[0].thoroughfare +
                ", " +
                _placemark[0].subThoroughfare +
                ", " +
                _placemark[0].subLocality +
                ", " +
                _placemark[0].locality +
                ", " +
                _placemark[0].subAdministrativeArea +
                ", " +
                _placemark[0].administrativeArea +
                ", " +
                _placemark[0].country
          ]);
        });

    _markers[markerId] = marker;
    notifyListeners();
  }

  void removeMarker(String id, int index) {
    _markers.remove(MarkerId(id));
    _address.removeAt(index);
    notifyListeners();
  }

  void placeMarkToAddress() {
    _address = _placemark
        .map((value) =>
            value.thoroughfare +
            ", " +
            value.subThoroughfare +
            ", " +
            value.subLocality +
            ", " +
            value.locality +
            ", " +
            value.subAdministrativeArea +
            ", " +
            value.administrativeArea +
            ", " +
            value.country)
        .toList();

    _cameraPosition = CameraPosition(
        target: LatLng(positionNow.latitude, positionNow.longitude),
        zoom: 14.151926040649414);
    goToMyPos();
    notifyListeners();
  }

  Future<void> goToMyPos() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
