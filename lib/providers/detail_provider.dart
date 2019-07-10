import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/shared/enum.dart';
import 'package:pet_adoption/shared/models/pet.dart';

class DetailProvider extends ChangeNotifier {
  Pet _pet;
  Pet get pet => _pet;

  Map<String, bool> _isWidgetEditable = {
    'petName': false,
    'typePet': false,
    'detailAddress': false,
    'aboutPet': false
  };
  Map<String, bool> get isWidgetEditable => _isWidgetEditable;

  bool _isEditable = false;
  bool get isEditable => _isEditable;

  PetModeEdit _petModeEdit = PetModeEdit.isview;
  PetModeEdit get petModeEdit => _petModeEdit;

  TextEditingController _petNameController = TextEditingController();
  TextEditingController get petNameController => _petNameController;

  TextEditingController _detailAddressController = TextEditingController();
  TextEditingController get detailAddressController => _detailAddressController;

  TextEditingController _aboutPetController = TextEditingController();
  TextEditingController get aboutPetController => _aboutPetController;

  Map<String, int> _generalPetValue;
  Map<String, int> get generalPetValue => _generalPetValue;

  Map<String, DocumentReference> _selectedColor;
  Map<String, DocumentReference> get selectedColor => _selectedColor;

  void setEditable(val) {
    _isEditable = val;
  }

  void setPet(val) {
    if(_pet == null)
      _pet = val;
  }

  void setPetModeEdit(val) {
    _petModeEdit = val;
    notifyListeners();
  }

  void setEdit(List val) {
    if (isEditable) {
      _isWidgetEditable[val[0]] = val[1];
      _petNameController.text = _pet.petName;
      _aboutPetController.text = _pet.aboutPet;
      _detailAddressController.text = _pet.addressShelter;

      notifyListeners();
    }
  }
    void setAddress(List<String> address) {
    if (address != null) {
      _detailAddressController.text = address[1];
      _detailAddressController.notifyListeners();
    }
    notifyListeners();
  }


  void update(Map<String, dynamic> val) async {
    _pet = _pet.fromMap(val);
    notifyListeners();

    await Firestore.instance
        .collection("pets")
        .document(pet.docId)
        .updateData(val);
  }

  void initGeneralPetValue(data) {
    if (_generalPetValue == null) {
      _generalPetValue =
          Map.fromIterable(data, key: (v) => v['name'], value: (v) => 0);
      _selectedColor = Map.fromIterable(data,
          key: (v) => v['name'], value: (v) => v['color']);
    }
  }

  Stream<QuerySnapshot> fetchGeneralPet() {
    return Firestore.instance.collection("generals").snapshots();
  }
}
