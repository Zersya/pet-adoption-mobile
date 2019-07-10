import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pet_adoption/shared/enum.dart';

class GivinPetProvider extends ChangeNotifier {

  PetModeEdit _petModeEdit = PetModeEdit.isview;
  PetModeEdit get petModeEdit => _petModeEdit;

  void setPetModeEdit(mode){
    _petModeEdit = mode;
    notifyListeners();
  }

  
  Stream<QuerySnapshot> fechPet(email) {
    return Firestore.instance.collection("pets").where('email', isEqualTo: email).snapshots();
  }
}