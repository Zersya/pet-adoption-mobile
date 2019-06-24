import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

enum StatusDrawer {
  open,
  closed,
}

class HomeProvider with ChangeNotifier {
  Map _selectedChip;
  Map get selectedChip => _selectedChip;

  String _address;
  String get address => _address;

  bool isInit = true;

//=================ANIMATION==============================
  StatusDrawer _statusDrawer = StatusDrawer.closed;
  StatusDrawer get statusDrawer => _statusDrawer;

  AnimationController _animationController;
  AnimationController get animationController => _animationController;

  Animation<double> _contentPositionX;
  Animation<double> get contentPositionX => _contentPositionX;

  Animation<double> _contentPositionY;
  Animation<double> get contentPositionY => _contentPositionY;

  Animation<double> _contentScale;
  Animation<double> get contentScale => _contentScale;

  Animation<BorderRadius> _borderRadius;
  Animation<BorderRadius> get borderRadius => _borderRadius;

  void initMenu(vsync, double posY) {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: vsync);

    _contentPositionX = Tween(begin: 0.0, end: 220.0).animate(CurvedAnimation(
        curve: Interval(0.0, 0.5, curve: Curves.ease),
        parent: _animationController.view));

    _contentPositionY = Tween(begin: 0.0, end: posY).animate(CurvedAnimation(
        curve: Interval(0.0, 0.5, curve: Curves.ease),
        parent: _animationController.view));

    _contentScale = Tween(begin: 1.0, end: 0.8).animate(CurvedAnimation(
        curve: Interval(0.0, 0.5, curve: Curves.ease),
        parent: _animationController.view));

    _borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(35.0),
    ).animate(CurvedAnimation(
      parent: _animationController.view,
      curve: Interval(
        0.200,
        0.800,
        curve: Curves.easeOut,
      ),
    ));

    _animationController.forward().orCancel;
  }

  void disposeMenu() {
    _animationController.dispose();
    notifyListeners();
  }

  void openDrawer() async {
    switch (_statusDrawer) {
      case StatusDrawer.closed:
       await _animationController.forward().orCancel;
        _statusDrawer = StatusDrawer.open;
        break;
      case StatusDrawer.open:
        await _animationController.reverse().orCancel;
        _statusDrawer = StatusDrawer.closed;
        break;
    }
    print(_statusDrawer);
    notifyListeners();
  }

//========================================================

  void initChoiceChip(List data) {
    if (isInit) {
      _selectedChip =
          Map.fromIterable(data, key: (v) => v, value: (v) => false);
      isInit = false;
    }
  }

  void selectedChoiceChip(String key, value) {
    _selectedChip[key] = value;
    notifyListeners();
  }

  void setAddress(String address) {
    _address = address;
    notifyListeners();
  }

  Stream<DocumentSnapshot> fetchCategory() {
    return Firestore.instance
        .collection("utilitys")
        .document("category")
        .snapshots();
  }
}
