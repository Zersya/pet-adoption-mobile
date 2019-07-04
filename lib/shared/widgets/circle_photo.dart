
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class CirclePhoto extends StatelessWidget {
  final diameter;

  const CirclePhoto({Key key, this.diameter = 40.0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);

    return Container(
      width: this.diameter,
      height: this.diameter,
      decoration: BoxDecoration(
          color: CustomColor.accentColor,
          shape: BoxShape.circle,
          image: DecorationImage(
              image: CachedNetworkImageProvider(_authProvider.user.photoUrl))),
    );
  }
}