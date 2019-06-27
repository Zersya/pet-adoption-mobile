import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:pet_adoption/providers/add_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class AddPetTwoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AddProvider _addProvider = Provider.of<AddProvider>(context);

    return SingleChildScrollView(
      child: Column(
          children: _addProvider.generalPetValue.keys.map((val) {
        return CircularSlider(
          title: val,
          backgroundColor:
              CustomColor.selectedColor[_addProvider.selectedColor[val]].backgroundColor,
          baseColor: CustomColor.selectedColor[_addProvider.selectedColor[val]].middleColor,
          selectionColor:
              CustomColor.selectedColor[_addProvider.selectedColor[val]].foregroundColor,
        );
      }).toList()),
    );
  }
}

class CircularSlider extends StatelessWidget {
  final title, backgroundColor, baseColor, selectionColor;

  const CircularSlider(
      {Key key,
      this.title,
      this.backgroundColor,
      this.baseColor,
      this.selectionColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddProvider _addProvider = Provider.of<AddProvider>(context);

    return Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: this.backgroundColor,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: <Widget>[
            Text(this.title,
                style: TextStyle(fontSize: 18.0, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            LimitedBox(
              maxHeight: 150.0,
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        _addProvider.generalPetValue[this.title].toString() +
                            "%",
                        style: TextStyle(fontSize: 26.0),
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: SingleCircularSlider(
                      100,
                      0,
                      baseColor: this.baseColor,
                      handlerColor: CustomColor.accentColor,
                      selectionColor: this.selectionColor,
                      onSelectionChange: (init, val, end) {
                        _addProvider.setGeneralPetValue(this.title, val);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
