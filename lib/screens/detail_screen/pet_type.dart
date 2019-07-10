import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/detail_provider.dart';
import 'package:pet_adoption/providers/typeSelect_provider.dart';
import 'package:pet_adoption/shared/widgets/type_selection.dart';
import 'package:provider/provider.dart';

class PetTypeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailProvider _detailProvider = Provider.of<DetailProvider>(context);
    TypeSelectProvider _typeSelectProvider =
        Provider.of<TypeSelectProvider>(context);

    if (!_detailProvider.isWidgetEditable['typePet'])
      return GestureDetector(
        onTap: () {
          _detailProvider.setEdit(['typePet', true]);
        },
        child: Text(_detailProvider.pet.typePet,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            )),
      );
    else
      return LimitedBox(
        maxHeight: 80,
        child: StreamProvider<QuerySnapshot>.value(
            value: _typeSelectProvider.fetchCategories(),
            child: TypeSelection(
              onTap: (val) {
                _detailProvider.setEdit(['typePet', false]);
                _detailProvider.update({'typePet': val});
              },
            )),
      );
  }
}
