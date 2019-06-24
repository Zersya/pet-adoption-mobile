import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/home_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/router.dart';
import 'package:pet_adoption/shared/widgets/choicechip_type.dart';
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
              child: CustomScrollView(slivers: <Widget>[
                new HeaderHome(),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  delegate: SliverChildListDelegate(
                    [
                      BodyWidget(Colors.blue),
                      BodyWidget(Colors.green),
                      BodyWidget(Colors.yellow),
                      BodyWidget(Colors.orange),
                      BodyWidget(Colors.blue),
                      BodyWidget(Colors.red),
                      BodyWidget(Colors.amber),
                    ],
                  ),
                ),
              ]),
            )
          ],
        )),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  final Color color;

  BodyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      color: color,
      alignment: Alignment.center,
      child: Text("aosakosakodsoak"),
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
                width: 35.0,
              ),
            ),
            CircleAvatar(
              backgroundColor: CustomColor.accentColor,
              child: Icon(Icons.person),
            )
          ],
        ),
        SizedBox(height: 40),
        Text(
          "Shelter near",
          style: TextStyle(
              color: CustomColor.accentColor, fontWeight: FontWeight.w600),
        ),
        Provider<String>.value(
          value: _homeProvider.address,
          child: GestureDetector(
              onTap: () async {
                String address = await Navigator.of(context)
                    .pushNamed(Router.mapPage) as String;
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
        StreamProvider<DocumentSnapshot>.value(
          value: _homeProvider.fetchCategory(),
          child: Consumer<DocumentSnapshot>(
            builder: (context, DocumentSnapshot value, child) {
              if (value == null) {
                return CircularProgressIndicator();
              }

              List data = value.data['data'];

              _homeProvider.initChoiceChip(data);

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: data
                      .map((val) => new ChoiceChipType(
                            type: val,
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
