import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/add_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class TypeSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddProvider _addProvider = Provider.of<AddProvider>(context);
    QuerySnapshot _querySnapshot = Provider.of<QuerySnapshot>(context);

    if(_querySnapshot == null) return Center(child: CircularProgressIndicator());
    List<DocumentSnapshot> _listCategory = _querySnapshot.documents;

    _addProvider.init(_listCategory.length);

    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Container(
                width: 60,
                decoration: BoxDecoration(
                    color: CustomColor.accentColor,
                    borderRadius: BorderRadius.circular(15.0)))),
        PageView.builder(
          onPageChanged: (index) {
            _addProvider.onPageTypeChange(index);
          },
          pageSnapping: true,
          controller: PageController(
              keepPage: true, viewportFraction: 0.20, initialPage: 0),
          scrollDirection: Axis.horizontal,
          itemCount: _listCategory.length,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: _addProvider.scaleType[index],
                    height: _addProvider.scaleType[index],
                    decoration: BoxDecoration(
                        color: CustomColor.accentColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                _listCategory[index].data['image']))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(_listCategory[index].data['name']),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}