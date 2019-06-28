
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/add_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class ImageSelectContainer extends StatelessWidget {
  final index;

  ImageSelectContainer({Key key, @required this.index}) : super(key: key);

  File _image;

  @override
  Widget build(BuildContext context) {
    AddProvider _addProvider = Provider.of<AddProvider>(context);
    _image = _addProvider.image[index];
    return GestureDetector(
      onTap: () => _addProvider.getImage(index),
      child: Card(
        color: CustomColor.accentColor,
        elevation: 5.0,
        child: Container(
          margin: EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: _addProvider.image[index] != null
              ? Image.file(
                  _image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : Icon(
                  Icons.add,
                  size: 48.0,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
