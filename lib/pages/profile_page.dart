import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    FirebaseUser _user = _authProvider.user;
    if (_user == null)
      return SpinKitRotatingCircle(
        color: CustomColor.accentColor,
        size: 50.0,
      );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Hero(
                tag: "profilePict",
                child: CachedNetworkImage(
                  imageUrl: _user.photoUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text(_user.displayName),
                  )
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: FloatingActionButton(
                backgroundColor: CustomColor.accentColor,
                child: Icon(
                  MdiIcons.logout,
                  color: Colors.white,
                  size: 28.0,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Want to Logout ?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("No"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            FlatButton(
                              child: Text("Yes"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _authProvider.handleSignOut();
                                Navigator.of(context).pop();

                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
