import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_adoption/providers/add_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Pet"),
        ),
        body: ChangeNotifierProvider(
            builder: (_) => AddProvider(),
            child: Consumer<AddProvider>(
              builder: (context, value, child) {
                return Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: ImageContainer(
                                index: 0,
                              )),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Flexible(
                                    flex: 1,
                                    child: ImageContainer(
                                      index: 1,
                                    )),
                                Flexible(
                                    flex: 1,
                                    child: ImageContainer(
                                      index: 2,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        child: Icon(Icons.info),
                      ),
                    )
                  ],
                );
              },
            )));
  }
}

class ImageContainer extends StatelessWidget {
  final index;

  ImageContainer({Key key, @required this.index}) : super(key: key);

  File _image;

  @override
  Widget build(BuildContext context) {
    AddProvider _addProvider = Provider.of<AddProvider>(context);
    _image = _addProvider.image[index];
    return GestureDetector(
      onTap: () => _addProvider.getImage(index),
      child: Card(
        color: CustomColor.accentColor,
        elevation: 10.0,
        child: Container(
          margin: EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: _addProvider.image[index] != null
              ? Image.file(
                  _image,
                  fit: BoxFit.cover,
                  width: double.infinity,
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
