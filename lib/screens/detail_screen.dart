import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/detail_provider.dart';
import 'package:pet_adoption/providers/typeSelect_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/models/generalPet.dart';
import 'package:pet_adoption/shared/models/pet.dart';
import 'package:pet_adoption/shared/router.dart';
import 'package:pet_adoption/shared/widgets/general_shimmer.dart';
import 'package:pet_adoption/shared/widgets/location_pick.dart';
import 'package:pet_adoption/shared/widgets/radial_progress.dart';
import 'package:provider/provider.dart';

import 'detail_screen/pet_name.dart';
import 'detail_screen/pet_type.dart';

class DetailPetScreen extends StatelessWidget {
  const DetailPetScreen({
    Key key,
    @required Pet pet,
    this.editable = false,
  })  : _pet = pet,
        super(key: key);

  final Pet _pet;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    DetailProvider _detailProvider = Provider.of<DetailProvider>(context);
    _detailProvider.setPet(this._pet);
    _detailProvider.setEditable(this.editable);

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PetNameWidget(),
                    SizedBox(
                      height: 2.5,
                    ),
                    ChangeNotifierProvider(
                      builder: (_) => TypeSelectProvider(),
                      child: PetTypeWidget(),
                    )
                  ],
                ),
              ),
              if (!this.editable)
                Icon(
                  MdiIcons.heartCircleOutline,
                  size: 32,
                  color: Colors.red,
                )
            ],
          ),
          Divider(
            height: 15,
          ),
          new PetAddressWidget(),
          Divider(
            height: 15,
            color: Colors.black87,
          ),
          Text("General",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          MultiProvider(
            providers: [
              StreamProvider.value(
                value: _detailProvider.fetchGeneralPet(),
              ),
              Provider<Pet>.value(
                value: _pet,
              )
            ],
            child: DetailGeneralValue(),
          ),
          Divider(
            height: 30,
            color: Colors.black87,
          ),
          Text("About",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_pet.aboutPet,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                )),
          ),
          if (!this.editable)
            Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                color: CustomColor.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  "Adopt",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
            )
        ],
      ),
    );
  }
}

class PetAddressWidget extends StatelessWidget {
  const PetAddressWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailProvider _detailProvider = Provider.of<DetailProvider>(context);
    // TextEditingController _controller =
    //     TextEditingController(text: _detailProvider.pet.addressShelter);

    if (!_detailProvider.isWidgetEditable['detailAddress'])
      return GestureDetector(
        onTap: () {
          _detailProvider.setEdit(['detailAddress', true]);
        },
        child: Row(
          children: <Widget>[
            Icon(Icons.location_on, color: CustomColor.accentColor, size: 38),
            SizedBox(width: 24.0),
            Expanded(
              child: Text(_detailProvider.pet.addressShelter),
            )
          ],
        ),
      );
    else {
      return Column(
        children: <Widget>[
          Provider<String>.value(
            value: _detailProvider.pet.addressShelter.substring(0, 21) + "...",
            child: GestureDetector(
                onTap: () async {
                  List<String> address = await Navigator.of(context)
                      .pushNamed(Router.mapPage) as List<String>;
                      _detailProvider.setAddress(address);
                      _detailProvider.update({'addressShelter': address[1]});
                },
                child: LocationPick()),
          ),
          TextFormField(
            controller: _detailProvider.detailAddressController,
            maxLength: 240,
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
                suffix: GestureDetector(
                    onTap: () {
                      _detailProvider.setEdit(['detailAddress', false]);
                      _detailProvider.update({
                        'addressShelter': _detailProvider.detailAddressController,
                      });
                    },
                    child: Icon(Icons.done)),
                hintText: "Detail Address",
                filled: true,
                fillColor: Colors.black12),
          ),
        ],
      );
    }
  }
}

class DetailGeneralValue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuerySnapshot _snapshot = Provider.of<QuerySnapshot>(context);
    DetailProvider _detailProvider = Provider.of<DetailProvider>(context);
    Pet _pet = Provider.of<Pet>(context);

    if (_snapshot == null || _detailProvider == null)
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            GeneralShimmer(),
            GeneralShimmer(),
            GeneralShimmer(),
          ],
        ),
      );

    _detailProvider.initGeneralPetValue(_snapshot.documents);

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ..._detailProvider.generalPetValue.keys.map((v) {
              return StreamProvider.value(
                value: _detailProvider.selectedColor[v].snapshots(),
                child: Consumer<DocumentSnapshot>(
                  builder: (context, document, child) {
                    if (document == null) return GeneralShimmer();
                    CustomDataColor _background =
                        CustomDataColor.fromMap(document.data['background']);
                    CustomDataColor _midground =
                        CustomDataColor.fromMap(document.data['midground']);
                    CustomDataColor _foreground =
                        CustomDataColor.fromMap(document.data['foreground']);

                    Color _foreColor = Color.fromRGBO(_foreground.red,
                        _foreground.green, _foreground.blue, _foreground.alpha);
                    Color _backColor = Color.fromRGBO(_background.red,
                        _background.green, _background.blue, _background.alpha);
                    Color _midColor = Color.fromRGBO(_midground.red,
                        _midground.green, _midground.blue, _midground.alpha);

                    return Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      height: 130.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                          color: _backColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(v,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              )),
                          RadialProgress(
                            lineColor: _midColor,
                            progressColor: _foreColor,
                            radius: 50,
                            strokeWidth: 8,
                            percent: _pet.generalPetValues[v],
                            child:
                                Text(_pet.generalPetValues[v].toString() + " %",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    )),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
