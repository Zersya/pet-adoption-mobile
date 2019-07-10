import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/add_provider.dart';
import 'package:pet_adoption/providers/typeSelect_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class TypeSelection extends StatelessWidget {
  final Function onTap;

  const TypeSelection({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TypeSelectProvider _typeSelectProvider =
        Provider.of<TypeSelectProvider>(context);
    QuerySnapshot _querySnapshot = Provider.of<QuerySnapshot>(context);

    if (_querySnapshot == null)
      return Center(child: CircularProgressIndicator());
    List<DocumentSnapshot> _listCategory = _querySnapshot.documents;

    _typeSelectProvider.init(_listCategory);

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
            _typeSelectProvider.onPageTypeChange(index);
          },
          pageSnapping: true,
          controller: PageController(
              keepPage: true, viewportFraction: 0.20, initialPage: _typeSelectProvider.selectedType == null ? 0:_typeSelectProvider.selectedType),
          scrollDirection: Axis.horizontal,
          itemCount: _listCategory.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onTap(_typeSelectProvider.petType),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      width: _typeSelectProvider.scaleType[index],
                      height: _typeSelectProvider.scaleType[index],
                      decoration: BoxDecoration(
                          color: CustomColor.accentColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  _listCategory[index].data['image']))),
                      duration: Duration(milliseconds: 200),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(_listCategory[index].data['name']),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
