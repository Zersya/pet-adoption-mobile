import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:pet_adoption/providers/home_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/router.dart';
import 'package:pet_adoption/shared/widgets/circle_photo.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40.0, left: 15, right: 15),
        color: CustomColor.accentColor,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: CirclePhoto(),
              title: Text(_authProvider.user.displayName, style:TextStyle(fontWeight: FontWeight.w700),),
            ),
            ListTile(
              onTap: () {
                Provider.of<HomeProvider>(context).openDrawer();
                Navigator.of(context).pushNamed(Router.addPage);
              },
              leading:  Icon(
                  Icons.pets,
                  color: CustomColor.primaryColor,
                ),
              title: Text("Giving somone pet", style:TextStyle(fontWeight: FontWeight.w500),),
            ),
          ],
        ),
      ),
    );
  }
}
