import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider with ChangeNotifier {
  Map _selectedChip;
  Map get selectedChip => _selectedChip;

  bool isInit = true;

  void initChoiceChip(List data) {
    if (isInit) {
      _selectedChip =
          Map.fromIterable(data, key: (v) => v, value: (v) => false);
      print("Init");
      isInit = false;
    }
  }

  void selectedChoiceChip(String key, value) {
    _selectedChip[key] = value;
    notifyListeners();
  }

  Stream<DocumentSnapshot> fetchCategory() {
    return Firestore.instance
        .collection("utilitys")
        .document("category")
        .snapshots();
  }
}
