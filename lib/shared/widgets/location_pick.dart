import 'package:flutter/material.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class LocationPick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String address = Provider.of<String>(context);
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black26))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              address != null ? address : "Search Location",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ),
          Icon(
            Icons.location_on,
            color: CustomColor.accentColor,
          ),
        ],
      ),
    );
  }
}