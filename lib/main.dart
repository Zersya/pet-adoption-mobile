import 'package:flutter/material.dart';
import 'package:pet_adoption/pages/auth_page.dart';
import 'package:pet_adoption/pages/home_page.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:pet_adoption/providers/home_provider.dart';
import 'package:pet_adoption/shared/router.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          builder: (_) => HomeProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, value, _) {

          return MaterialApp(
            onGenerateRoute: Router.generateRoute,
            title: 'Pet Adoption',
            theme: ThemeData(
                primarySwatch: Colors.brown, fontFamily: "Open Sans"),
            home: value.user != null
                ? HomePage()
                : AuthPage(),
          );
        },
      ),
    );
  }
}
