import 'package:flutter/material.dart';
import 'package:pet_adoption/shared/custom_color.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40.0, left: 15, right: 15),
        color: CustomColor.accentColor,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: CustomColor.primaryColor,
                child: Icon(
                  Icons.person,
                  color: CustomColor.accentColor,
                ),
              ),
              title: Text("Zein Ersyad", style:TextStyle(fontWeight: FontWeight.w700),),
            ),
            ListTile(
              leading:  Icon(
                  Icons.access_alarm,
                  color: CustomColor.primaryColor,
                ),
              title: Text("Alarm", style:TextStyle(fontWeight: FontWeight.w500),),
            ),
            ListTile(
              leading:  Icon(
                  Icons.add_a_photo,
                  color: CustomColor.primaryColor,
                ),
              title: Text("Add Photo", style:TextStyle(fontWeight: FontWeight.w500),),
            ),
            ListTile(
              leading:  Icon(
                  Icons.airline_seat_flat,
                  color: CustomColor.primaryColor,
                ),
              title: Text("Airline seat", style:TextStyle(fontWeight: FontWeight.w500),),
            ),
          ],
        ),
      ),
    );
  }
}
