import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/home_provider.dart';
import 'package:pet_adoption/screens/home_screen.dart';
import 'package:pet_adoption/screens/menu_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  @override
  void dispose() {
    super.dispose();
    Provider.of<HomeProvider>(context, listen: false).disposeMenu();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider _homeProvider = Provider.of<HomeProvider>(context);
    _homeProvider.initMenu(
        this,
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2,
        MediaQuery.of(context).size.height);

    return Stack(
      children: <Widget>[
        MenuDrawer(),
        AnimatedContainer(
          transform: Matrix4.identity()
            ..translate(
                _homeProvider.contentPositionX.value,
                _homeProvider.contentPositionY.value -
                    _homeProvider.contentPositionY.value *
                        _homeProvider.contentScale.value)
            ..scale(_homeProvider.contentScale.value),
          child: Stack(
            children: <Widget>[
              HomeScreen(),
              GestureDetector(
                  onHorizontalDragStart: (DragStartDetails val) {
                    _homeProvider.openDrawer();
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width / 30,
                    height: MediaQuery.of(context).size.height,
                  )),
            ],
          ),
          duration: _homeProvider.animationController.duration,
        ),
      ],
    );
  }
}
