import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum StateSubmit { notSubmited, isLoading, Submited }

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

  String _genderPet;
  String get genderPet => _genderPet;

  DateTime _dateofBirth;
  DateTime get dateofBirth => _dateofBirth;

  Map<String, int> _generalPetValue;
  Map<String, int> get generalPetValue => _generalPetValue;

  Map<String, DocumentReference> _selectedColor;
  Map<String, DocumentReference> get selectedColor => _selectedColor;

  StateSubmit _stateAddPet = StateSubmit.notSubmited;
  StateSubmit get stateAddPet => _stateAddPet;

  Future submitPet(_callback) async {
    String _petName = _namePetController.text;
    String _aboutPet = _aboutPetController.text;
    String _typePet = _petType[_selectedType] as String;
    String _addressShelter = _address[1]; //Detail address

    if (_petName == null ||
        _aboutPet == null ||
        _typePet == null ||
        _genderPet == null ||
        _addressShelter == null ||
        _address[0] == null ||
        _address[1] == null ||
        _address[2] == null ||
        _address[3] == null ||
        _dateofBirth == null ||
        _image[0] == null) {
      _callback();
      return;
    }
    GeoPoint _geoShelter =
        GeoPoint(double.parse(_address[2]), double.parse(_address[3]));
    List<String> _urls = List();
    
    _stateAddPet = StateSubmit.isLoading;
    notifyListeners();
    

    for (int i = 0; i < _image.length; i++) {
      String url = await _uploadImage(_image[i], _petName, i);
      if (url != null) _urls.add(url);
    }

    FirebaseUser _firebaseUser = await FirebaseAuth.instance.currentUser();
    String _docId = Firestore.instance.collection("pets").document().documentID;
    await Firestore.instance.collection("pets").document(_docId).setData({
      'docId': _docId,
      'petName': _petName,
      'aboutPet': _aboutPet,
      'typePet': _typePet,
      'addressShelter': _addressShelter,
      'genderPet': _genderPet,
      'dateofbirth': _dateofBirth.toLocal().millisecondsSinceEpoch,
      'isAdopted': false,
      'geoShelter': _geoShelter,
      'generalPetValues': _generalPetValue,
      'imageUrls': _urls,
      'email': _firebaseUser.email,
      'displayName': _firebaseUser.displayName,
      'phoneNumber': _firebaseUser.phoneNumber
    });
    _stateAddPet = StateSubmit.Submited;
    notifyListeners();
  }

  Future<String> _uploadImage(image, petName, index) async {
    if (image == null) {
      return null;
    }
    final String filename = petName + index.toString() + extension(image.path);
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child(filename);
    final StorageUploadTask uploadTask = storageRef.putFile(image);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());

    return url;
  }

  void initGeneralPetValue(data) {
    if (_generalPetValue == null) {
      _generalPetValue =
          Map.fromIterable(data, key: (v) => v['name'], value: (v) => 0);
      _selectedColor = Map.fromIterable(data,
          key: (v) => v['name'], value: (v) => v['color']);
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

  void setGender(String val) {
    _genderPet = val;
    notifyListeners();
  }

  void setDateofBirth(DateTime _dateTime) {
    _dateofBirth = _dateTime;
    notifyListeners();
  }

  Stream<QuerySnapshot> fetchCategories() {
    return Firestore.instance.collection("categories").snapshots();
  }

  Stream<QuerySnapshot> fetchGeneralPet() {
    return Firestore.instance.collection("generals").snapshots();
  }
}
