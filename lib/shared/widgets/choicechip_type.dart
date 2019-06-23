import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/home_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class ChoiceChipType extends StatelessWidget {
  final type;
  const ChoiceChipType({
    Key key, this.type,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    HomeProvider _homeProvider = Provider.of<HomeProvider>(context);
    bool _isSelected = _homeProvider.selectedChip[type];

    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: ChoiceChip(
        selectedColor: CustomColor.accentColor,
        backgroundColor: CustomColor.primaryColor,
        labelStyle: _isSelected ? TextStyle(color: Colors.white):TextStyle(color: CustomColor.accentColor),
        label: Text(type),
        selected: _isSelected,
        onSelected: (value) {
          _homeProvider.selectedChoiceChip(type, value);
        },
      ),
    );
  }
}
