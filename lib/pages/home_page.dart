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
  void initState() {
    super.initState();

    Provider.of<HomeProvider>(context, listen: false).initMenu(this, 80.0);
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<HomeProvider>(context, listen: false).disposeMenu();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider _homeProvider = Provider.of<HomeProvider>(context);
    return Stack(
      children: <Widget>[
        MenuDrawer(),
        AnimatedContainer(
          transform: Matrix4.identity()
            ..translate(_homeProvider.contentPositionX.value, _homeProvider.contentPositionY.value)
            ..scale(_homeProvider.contentScale.value),
          child: HomeScreen(),
          duration: _homeProvider.animationController.duration,
        ),
      ],
    );
  }
}
