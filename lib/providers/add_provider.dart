import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AddProvider with ChangeNotifier {
  List<File> _image = List(3);
  List<File> get image => _image;

  void getImage(index) async {
    _image[index] = await ImagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }
}
