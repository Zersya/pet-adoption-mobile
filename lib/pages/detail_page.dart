import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/detail_provider.dart';
import 'package:pet_adoption/providers/typeSelect_provider.dart';
import 'package:pet_adoption/screens/detail_screen.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/models/generalPet.dart';
import 'package:pet_adoption/shared/models/pet.dart';
import 'package:pet_adoption/shared/widgets/general_shimmer.dart';
import 'package:pet_adoption/shared/widgets/radial_progress.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Pet pet;

  const DetailPage({Key key, this.pet}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Pet _pet;

  @override
  void initState() {
    _pet = widget.pet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => DetailProvider(),
        ),
      ],
      child: Consumer<DetailProvider>(builder: (context, value, child) {
        return Scaffold(
            body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height / 2,
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                FloatingActionButton(
                  heroTag: "menuBtn",
                  mini: true,
                  elevation: 5.0,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black87,
                  ),
                  onPressed: () {},
                )
              ],
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: FloatingActionButton(
                  heroTag: "backBtn",
                  mini: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  elevation: 5.0,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: _pet.docId,
                  child: CachedNetworkImage(
                    imageUrl: _pet.imageUrls[0],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: new DetailPetScreen(pet: _pet),
            )
          ],
        ));
      }),
    );
  }
}

