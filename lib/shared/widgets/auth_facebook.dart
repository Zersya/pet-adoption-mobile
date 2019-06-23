import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:provider/provider.dart';

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