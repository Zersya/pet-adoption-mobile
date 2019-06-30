import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pet_adoption/providers/add_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/models/generalPet.dart';
import 'package:provider/provider.dart';

class AddPetTwoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddProvider _addProvider = Provider.of<AddProvider>(context);
    QuerySnapshot _snapshot = Provider.of<QuerySnapshot>(context);
    if (_snapshot == null)
      return SpinKitRotatingCircle(
        color: CustomColor.accentColor,
        size: 50.0,
      );
    _addProvider.initGeneralPetValue(_snapshot.documents);

    return SingleChildScrollView(
      child: Column(children: [
        ..._addProvider.generalPetValue.keys.map((val) {
          return StreamProvider.value(
              value: _addProvider.selectedColor[val].snapshots(),
              child: Consumer<DocumentSnapshot>(
                builder: (context, document, child) {
                  if (document == null || document.data == null)
                    return SpinKitRotatingCircle(
                      color: CustomColor.accentColor,
                      size: 50.0,
                    );

                  CustomDataColor _background =
                      CustomDataColor.fromMap(document.data['background']);
                  CustomDataColor _midground =
                      CustomDataColor.fromMap(document.data['midground']);
                  CustomDataColor _foreground =
                      CustomDataColor.fromMap(document.data['foreground']);

                  return CircularSlider(
                      title: val,
                      backgroundColor: Color.fromRGBO(
                          _background.red,
                          _background.green,
                          _background.blue,
                          _background.alpha),
                      baseColor: Color.fromRGBO(_midground.red,
                          _midground.green, _midground.blue, _midground.alpha),
                      selectionColor: Color.fromRGBO(
                          _foreground.red,
                          _foreground.green,
                          _foreground.blue,
                          _foreground.alpha));
                },
              ));
        }).toList(),
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            color: CustomColor.accentColor,
            textColor: Colors.white,
            child: Text("Submit Pet"),
            onPressed: () {
              _addProvider.submitPet((){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Harap lengkapi data peliharaan"),));
              });
            },
          ),
        )
      ]),
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
                      _addProvider.generalPetValue[this.title],
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
