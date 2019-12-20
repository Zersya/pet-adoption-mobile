
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pet_adoption/providers/home_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/enum.dart';
import 'package:pet_adoption/shared/router.dart';
import 'package:pet_adoption/shared/widgets/card_pet.dart';
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
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                        color: CustomColor.primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.0))),
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
                              ...value.documents.map((val) => BodyWidget(val, PetNavigator.detailpet))
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
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Router.profilePage);
                },
                child: new CirclePhoto())
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
                return Center(
                  child: SpinKitThreeBounce(
                    color: CustomColor.accentColor,
                    size: 40.0,
                  ),
                );
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
