import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum StateSubmit {
  notSubmited,
  isLoading,
  Submited
}

class AddProvider with ChangeNotifier {
  List<File> _image = List(3);
  List<File> get image => _image;

  TextEditingController _namePetController = TextEditingController();
  TextEditingController get namePetController => _namePetController;

  TextEditingController _detailAddressController = TextEditingController();
  TextEditingController get detailAddressController => _detailAddressController;

  TextEditingController _aboutPetController = TextEditingController();
  TextEditingController get aboutPetController => _aboutPetController;

  PageController _pageController = PageController();
  PageController get pageController => _pageController;

  //Scaling selected Pet and not selected.
  List<double> _scaleType = List();
  List<double> get scaleType => _scaleType;

  List _petType = List();
  List get petType => _petType;

  int _selectedType = 0;
  int get selectedType => _selectedType;

  List<String> _address = [null, null, null, null];
  List<String> get address => _address;

  Map<String, int> _generalPetValue;
  Map<String, int> get generalPetValue => _generalPetValue;

  Map<String, int> _selectedColor;
  Map<String, int> get selectedColor => _selectedColor;

  StateSubmit _stateAddPet = StateSubmit.notSubmited;
  StateSubmit get stateAddPet => _stateAddPet;

  Future submitPet() async{
    _stateAddPet = StateSubmit.isLoading;
    notifyListeners();

    String _petName = _namePetController.text;
    String _aboutPet = _aboutPetController.text;
    String _typePet = _petType[_selectedType] as String;
    String _addressShelter = _address[1]; //Detail address
    GeoPoint _geoShelter =
        GeoPoint(double.parse(_address[2]), double.parse(_address[3]));
    List<String> _urls = List();

    for (int i = 0; i < _image.length; i++) {
      String url = await _uploadImage(_image[i], _petName, i);
      if (url != null) _urls.add(url);
    }

    await Firestore.instance.collection("pets").document().setData({
      'petName': _petName,
      'aboutPet': _aboutPet,
      'typePet': _typePet,
      'addressShelter': _addressShelter,
      'geoShelter': _geoShelter,
      'generalPetValues': _generalPetValue,
      'imageUrls': _urls
    });
    _stateAddPet = StateSubmit.Submited;
    notifyListeners();
  }

  Future<String> _uploadImage(image, petName, index) async {
    if (image == null) {
      return null;
    }
    final String filename =
        petName + index.toString() + extension(image.path);
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child(filename);
    final StorageUploadTask uploadTask = storageRef.putFile(image);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());

    return url;
  }

  void initGeneralPetValue(data) {
    if (_generalPetValue == null) {
      _generalPetValue = Map.fromIterable(data, key: (v) => v, value: (v) => 0);
      _selectedColor = Map.fromIterable(data,
          key: (v) => v, value: (v) => Random().nextInt(3));
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

  void init(List<DocumentSnapshot> categories) {
    if (_scaleType.length == 0) {
      for (var i = 0; i < categories.length; i++) _scaleType.add(20.0);
      _scaleType[0] = 45.0;
      _petType = categories.map((v) => v.data['name']).toList();
    }
  }

  void onPageTypeChange(index) {
    _selectedType = index;
    _scaleType[index] = 45.0;
    if (index > 0) _scaleType[index - 1] = 20.0;
    if (index < _scaleType.length - 1) _scaleType[index + 1] = 20.0;

    notifyListeners();
  }

  void setAddress(List<String> address) {
    if (address != null) {
      _address = address;
      _detailAddressController.text = address[1];
      _detailAddressController.notifyListeners();
    }
    notifyListeners();
  }

  Stream<QuerySnapshot> fetchCategories() {
    return Firestore.instance.collection("categories").snapshots();
  }
}
