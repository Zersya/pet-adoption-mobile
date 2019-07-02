import 'package:flutter/material.dart';
import 'package:pet_adoption/pages/add_page.dart';
import 'package:pet_adoption/pages/auth_page.dart';
import 'package:pet_adoption/pages/detail_page.dart';
import 'package:pet_adoption/pages/home_page.dart';
import 'package:pet_adoption/pages/map_page.dart';

class Router {
  static const String authPage = '/authpage';
  static const String homePage = '/homePage';
  static const String mapPage = '/mapPage';
  static const String addPage = '/addPage';
  static const String detailPage = '/detailPage';

  static Route<dynamic> generateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case authPage:
        return MaterialPageRoute(
          settings: RouteSettings(name: authPage),
          builder: (_) => AuthPage()
        );
      case homePage:
        return MaterialPageRoute(
            settings: RouteSettings(name: homePage),
            builder: (_) => HomePage()
        );
      case mapPage:
        return MaterialPageRoute(
            settings: RouteSettings(name: mapPage),
            builder: (_) => MapPage()
        );
      case addPage:
        return MaterialPageRoute(
            settings: RouteSettings(name: addPage),
            builder: (_) => AddPage()
        );
      case detailPage:
        var data = routeSettings.arguments;
        return MaterialPageRoute(
            settings: RouteSettings(name: detailPage),
            builder: (_) => DetailPage(pet: data,)
        );
    }
  }
}