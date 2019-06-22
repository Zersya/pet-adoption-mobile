import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).checkUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: CustomColor.primaryColor,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/pet/cat1.png',
                  fit: BoxFit.contain,
                  height: 200.0,
                ),
                SizedBox(height: 50,),
                Text("Pet Adoption",
                  style: Theme.of(context).textTheme.title,),
                Text("Adopt any pet, and give them a good life.",
                  style: Theme.of(context).textTheme.subtitle, textAlign: TextAlign.center,),
                SizedBox(height: 50,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SignInGoogle(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("or"),
                    ),
                    SignInFacebook(),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class SignInGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Card(
      color: Colors.white,
      child: IconButton(
          icon: Image.asset('images/icons/icons8-google-96.png'),
          onPressed: () {
            _authProvider.handleSignInGoogle().catchError((err) {
              print(err);
            });
          }),
    );
  }
}

class SignInFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Card(
      color: Colors.white,
      child: IconButton(
          icon: Image.asset('images/icons/facebook.png'),
          onPressed: () {
            _authProvider.handleSignInFacebook().catchError((err) {
              if(err.code == "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL")
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Email telah terdaftar di Google')));
              else
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Ada kesalahan')));

            });
          }),
    );
  }
}

