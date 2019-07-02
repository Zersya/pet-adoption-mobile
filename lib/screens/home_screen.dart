import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/home_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/models/pet.dart';
import 'package:pet_adoption/shared/router.dart';
import 'package:pet_adoption/shared/widgets/choicechip_type.dart';
import 'package:pet_adoption/shared/widgets/circle_photo.dart';
import 'package:pet_adoption/shared/widgets/location_pick.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider _homeProvider = Provider.of<HomeProvider>(context);

    return GestureDetector(
      onTap: () {
        if (_homeProvider.statusDrawer == StatusDrawer.open)
          _homeProvider.openDrawer();
      },
      child: ClipRRect(
        borderRadius: _homeProvider.borderRadius.value,
        child: Scaffold(
            body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Container(
                    color: CustomColor.primaryColor,
                    height: MediaQuery.of(context).size.height / 1.5,
                  ),
                ),
                Flexible(flex: 1, child: Container())
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 15, right: 15),
              child: StreamProvider<QuerySnapshot>.value(
                value: _homeProvider.fetchPets(),
                child: Consumer<QuerySnapshot>(
                  builder: (context, value, child) {
                    if (value == null)
                      return SpinKitRotatingCircle(
                        color: CustomColor.accentColor,
                        size: 50.0,
                      );

                    return CustomScrollView(slivers: <Widget>[
                      new HeaderHome(),
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        delegate: SliverChildListDelegate(
                          [
                            if (value.documents.length > 0)
                              ...value.documents.map((val) => BodyWidget(val))
                            else
                              Center(
                                child: Text("No data found!"),
                              )
                          ],
                        ),
                      )
                    ]);
                  },
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;

  BodyWidget(this.snapshot);

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
        Navigator.of(context).pushNamed(Router.detailPage, arguments: _pet);
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

class HeaderHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeProvider _homeProvider = Provider.of<HomeProvider>(context);

    return SliverList(
      delegate: SliverChildListDelegate([
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _homeProvider.openDrawer();
              },
              child: Image.asset(
                "images/icons/menu_icon.png",
                width: 40.0,
              ),
            ),
            new CirclePhoto()
          ],
        ),
        SizedBox(height: 40),
        Text(
          "Shelter near",
          style: TextStyle(
              color: CustomColor.accentColor, fontWeight: FontWeight.w600),
        ),
        Provider<String>.value(
          value: _homeProvider.address[0],
          child: GestureDetector(
              onTap: () async {
                List<String> address = await Navigator.of(context)
                    .pushNamed(Router.mapPage) as List<String>;
                _homeProvider.setAddress(address);
              },
              child: LocationPick()),
        ),
        SizedBox(height: 20),
        Text(
          "Type",
          style: TextStyle(
              color: CustomColor.accentColor, fontWeight: FontWeight.w600),
        ),
        StreamProvider<QuerySnapshot>.value(
          value: _homeProvider.fetchCategories(),
          child: Consumer<QuerySnapshot>(
            builder: (context, QuerySnapshot value, child) {
              if (value == null) {
                return CircularProgressIndicator();
              }

              List<DocumentSnapshot> data = value.documents;

              _homeProvider.initChoiceChip(data);

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: data
                      .map((val) => new ChoiceChipType(
                            type: val.data['name'],
                          ))
                      .toList(),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
