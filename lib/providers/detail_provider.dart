import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DetailProvider extends ChangeNotifier {
  
  Map<String, int> _generalPetValue;
  Map<String, int> get generalPetValue => _generalPetValue;
  
  Map<String, DocumentReference> _selectedColor;
  Map<String, DocumentReference> get selectedColor => _selectedColor;

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