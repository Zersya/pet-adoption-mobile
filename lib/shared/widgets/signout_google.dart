import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:provider/provider.dart';

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
