import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var address = "Search Location";

  @override
  Widget build(BuildContext context) {
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
            Provider<String>.value(value: address, child: GestureDetector(
              onTap: ()async{
                address = await Navigator.of(context).pushNamed(Router.mapPage) as String;
              },
                child: LocationPick()),)
          ],
        )
      ],
    ));
  }
}

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
              address != null ? address:"Search Location",
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

class SignOutGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Card(
      color: Colors.white,
      child: IconButton(
          icon: Icon(MdiIcons.logout),
          onPressed: () {
            _authProvider.handleSignOut();
          }),
    );
  }
}
