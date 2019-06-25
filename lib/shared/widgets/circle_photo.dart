
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:provider/provider.dart';

class CirclePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);

    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
          color: CustomColor.accentColor,
          shape: BoxShape.circle,
          image: DecorationImage(
              image: CachedNetworkImageProvider(_authProvider.user.photoUrl))),
    );
  }
}