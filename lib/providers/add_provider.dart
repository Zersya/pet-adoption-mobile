import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProvider with ChangeNotifier {
  List<File> _image = List(3);
  List<File> get image => _image;

  TextEditingController _namePetController = TextEditingController();
  TextEditingController get namePetController => _namePetController;

  TextEditingController _detailAddressController = TextEditingController();
  TextEditingController get detailAddressController => _detailAddressController;

  List<double> _scaleType = List();
  List<double> get scaleType => _scaleType;

  List<String> _address = [null, null];
  List<String> get address => _address;

  Map<String, int> _generalPetValue;
  Map<String, int> get generalPetValue => _generalPetValue;

  Map<String, int> _selectedColor;
  Map<String, int> get selectedColor => _selectedColor;

  void initGeneralPetValue(data) {
    if (_generalPetValue == null) {
      _generalPetValue = Map.fromIterable(data, key: (v) => v, value: (v) => 0);
      _selectedColor = Map.fromIterable(data, key: (v) => v, value: (v) => Random().nextInt(3));
    }
  }

  void setGeneralPetValue(key, value) {
    _generalPetValue[key] = value;
    notifyListeners();
  }

  void getImage(index) async {
    _image[index] = await ImagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  void countingNameLen(value) {
    _namePetController = value;
    notifyListeners();
  }

  void init(len) {
    if (_scaleType.length == 0) {
      for (var i = 0; i < len; i++) _scaleType.add(20.0);
      _scaleType[0] = 45.0;
    }
  }

  void onPageTypeChange(index) {
    _scaleType[index] = 45.0;
    if (index > 0) _scaleType[index - 1] = 20.0;
    if (index < _scaleType.length - 1) _scaleType[index + 1] = 20.0;

    notifyListeners();
  }

  void setAddress(List<String> address) {
    _address = address;
    _detailAddressController.text = address[1];
    _detailAddressController.notifyListeners();
    notifyListeners();
  }

  Stream<QuerySnapshot> fetchCategories() {
    return Firestore.instance.collection("categories").snapshots();
  }
}
