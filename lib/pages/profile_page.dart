import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/widgets/circle_photo.dart';
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
      backgroundColor: CustomColor.accentColor,
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: CustomPaint(
                    willChange: false,
                    painter: ProfilePainter(),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Hero(
                              tag: "profilePict",
                              child: CirclePhoto(
                                diameter: 100.0,
                              )),
                          Text(_user.displayName),
                          Text(_user.email),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: double.infinity,
                    color: CustomColor.primaryColor,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                       
                      ],
                    ),
                  ),
                )
              ],
            ),
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
                  showDialogLogout(context, _authProvider);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future showDialogLogout(BuildContext context, AuthProvider _authProvider) {
    return showDialog(
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
  }
}

class MenuItem extends StatelessWidget {
  final onTap, title;
  const MenuItem({
    Key key,
    this.onTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          onTap: onTap,
        ),
        Divider(
          height: 8.0,
          color: Colors.black87,
        )
      ],
    );
  }
}

class ProfilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = CustomColor.primaryColor;

    Rect rectArc = Rect.fromLTWH(0, size.height / 2, size.width, 80);
    canvas.drawArc(rectArc, 0.0, 8, false, paint);

    Rect rectR =
        Rect.fromLTRB(0, (size.height / 2) + 40, size.width, size.height);
    canvas.drawRect(rectR, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
