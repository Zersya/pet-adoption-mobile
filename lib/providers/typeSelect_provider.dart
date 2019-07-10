import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TypeSelectProvider extends ChangeNotifier {
//Scaling selected Pet and not selected.
  List<double> _scaleType = List();
  List<double> get scaleType => _scaleType;

  List _petTypes = List();
  List get petTypes => _petTypes;

  String get petType => _petTypes[_selectedType];

  int _selectedType = 0;
  int get selectedType => _selectedType;

  void init(List<DocumentSnapshot> categories) {
    if (_scaleType.length == 0) {
      for (var i = 0; i < categories.length; i++) _scaleType.add(20.0);
      _scaleType[0] = 45.0;
      _petTypes = categories.map((v) => v.data['name']).toList();
    }
  }

  void onPageTypeChange(index) {
    _selectedType = index;
    _scaleType[index] = 45.0;
    if (index > 0) _scaleType[index - 1] = 20.0;
    if (index < _scaleType.length - 1) _scaleType[index + 1] = 20.0;

    notifyListeners();
  }

  Stream<QuerySnapshot> fetchCategories() {
    return Firestore.instance.collection("categories").snapshots();
  }
}
