import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/shared/enum.dart';
import 'package:pet_adoption/shared/models/pet.dart';
import 'package:pet_adoption/shared/router.dart';

class BodyWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final PetNavigator petNavigator;

  BodyWidget(this.snapshot, this.petNavigator);

  @override
  Widget build(BuildContext context) {
    int _daysPet =
        DateTime.fromMillisecondsSinceEpoch(this.snapshot.data['dateofbirth'])
            .difference(DateTime.now())
            .inDays
            .abs();

    Pet _pet = Pet.fromMap(this.snapshot.data);

    return GestureDetector(
      onTap: () {
        if(petNavigator == PetNavigator.detailpet)
          Navigator.of(context).pushNamed(Router.detailPage, arguments: _pet);

        if(petNavigator == PetNavigator.editpet)
          Navigator.of(context).pushNamed(Router.editPage, arguments: _pet);
      },
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Stack(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: _pet.docId,
                    child: CachedNetworkImage(
                      imageUrl: _pet.imageUrls[0],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )),
              Container(
                color: Colors.black12,
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _pet.petName,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _pet.typePet,
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            _pet.genderPet,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            _daysPet > 60
                                ? (_daysPet / 360).toStringAsFixed(2) + " yo"
                                : _daysPet.toString() + " days",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            MdiIcons.heartCircleOutline,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
