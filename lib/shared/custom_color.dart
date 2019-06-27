import 'package:flutter/material.dart';

class CustomColor {
  static const Color primaryColor = Color.fromRGBO(255, 216, 181, 1);
  static const Color accentColor = Color.fromRGBO(173, 138, 100, 1);

  static const List<SelectedColor> selectedColor = [
    SelectedColor(
        foregroundColor: Color.fromRGBO(246, 170, 127, 1),
        backgroundColor: Color.fromRGBO(255, 240, 227, 1),
        middleColor: Color.fromRGBO(246, 170, 127, 0.5)),
    SelectedColor(
        foregroundColor: Color.fromRGBO(59, 108, 197, 1),
        backgroundColor: Color.fromRGBO(226, 240, 255, 1),
        middleColor: Color.fromRGBO(59, 108, 197, 0.5)),
    SelectedColor(
        foregroundColor: Color.fromRGBO(219, 128, 135, 1),
        backgroundColor: Color.fromRGBO(255, 239, 245, 1),
        middleColor: Color.fromRGBO(219, 128, 135, 0.5)),
  ];
}

class SelectedColor {
  final Color foregroundColor, backgroundColor, middleColor;

  const SelectedColor({this.foregroundColor, this.backgroundColor, this.middleColor});
}
