import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/detail_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/models/generalPet.dart';
import 'package:pet_adoption/shared/models/pet.dart';
import 'package:pet_adoption/shared/widgets/general_shimmer.dart';
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
    return ChangeNotifierProvider(
      builder: (_) => DetailProvider(),
      child: Consumer<DetailProvider>(builder: (context, value, child) {
        return Scaffold(
            body: CustomScrollView(
              primary: true,
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height / 2,
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: FloatingActionButton(
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
                  tag: widget.pet.docId,
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
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_pet.petName,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text(_pet.typePet,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                )),
                          ],
                        ),
                        Icon(
                          MdiIcons.heartCircleOutline,
                          size: 32,
                          color: Colors.red,
                        )
                      ],
                    ),
                    Divider(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on,
                            color: CustomColor.accentColor, size: 38),
                        SizedBox(width: 24.0),
                        Expanded(child: Text(_pet.addressShelter)),
                      ],
                    ),
                    Divider(
                      height: 30,
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
                          value: value.fetchGeneralPet(),
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
              ),
            )
          ],
        ));
      }),
    );
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
                      height: 80.0,
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
                          Text(_pet.generalPetValues[v].toString() + " %",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              )),
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
