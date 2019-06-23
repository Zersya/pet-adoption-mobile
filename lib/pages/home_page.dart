import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:pet_adoption/providers/home_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/router.dart';
import 'package:pet_adoption/shared/widgets/choicechip_type.dart';
import 'package:pet_adoption/shared/widgets/location_pick.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var address = "Search Location";

  @override
  Widget build(BuildContext context) {
    HomeProvider _homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.asset("images/background.png"),
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 60),
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  "images/icons/menu_icon.png",
                  width: 35.0,
                ),
                CircleAvatar(
                  child: Icon(Icons.person),
                )
              ],
            ),
            SizedBox(height: 40),
            Text(
              "Shelter near",
              style: TextStyle(
                  color: CustomColor.accentColor, fontWeight: FontWeight.w600),
            ),
            Provider<String>.value(
              value: address,
              child: GestureDetector(
                  onTap: () async {
                    address = await Navigator.of(context)
                        .pushNamed(Router.mapPage) as String;
                  },
                  child: LocationPick()),
            ),
            SizedBox(height: 20),
            Text(
              "Type",
              style: TextStyle(
                  color: CustomColor.accentColor, fontWeight: FontWeight.w600),
            ),
            StreamProvider<DocumentSnapshot>.value(
              value: _homeProvider.fetchCategory(),
              child: Consumer<DocumentSnapshot>(
                builder: (context, DocumentSnapshot value, child) {
                  if (value == null) {
                    return CircularProgressIndicator();
                  }
                  
                  List data = value.data['data'];
                  
                  _homeProvider.initChoiceChip(data);

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: data.map((val) => new ChoiceChipType(type: val,)).toList(),
                    ),
                  );
                },
              ),
            )
          ],
        )
      ],
    ));
  }
}




