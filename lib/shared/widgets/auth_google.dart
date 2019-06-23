
import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:provider/provider.dart';

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