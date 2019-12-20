import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/detail_provider.dart';
import 'package:provider/provider.dart';

class PetNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailProvider _detailProvider = Provider.of<DetailProvider>(context);
    if (!_detailProvider.isWidgetEditable['petName'])
      return GestureDetector(
        onTap: () {
          _detailProvider.setEdit(['petName', true]);
        },
        child: Text(_detailProvider.pet.petName,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            )),
      );
    else
      return TextFormField(
        controller: _detailProvider.petNameController,
        onFieldSubmitted: (val) {
          _detailProvider.setEdit(['petName', false]);
          _detailProvider.update({'petName': val});
        },
        maxLength: 20,
        validator: (val) {
          if (val.isEmpty) return "Please Fill this field.";
          return null;
        },
        decoration: InputDecoration(
            hintText: "Pet Name", filled: true, fillColor: Colors.black12),
      );
  }
}
