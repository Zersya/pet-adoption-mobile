import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pet_adoption/providers/auth_provider.dart';
import 'package:pet_adoption/providers/givinPet_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/enum.dart';
import 'package:pet_adoption/shared/widgets/card_pet.dart';
import 'package:provider/provider.dart';

class GivinPetPage extends StatefulWidget {
  @override
  _GivinPetPageState createState() => _GivinPetPageState();
}

class _GivinPetPageState extends State<GivinPetPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    FirebaseUser _user = _authProvider.user;

    return Scaffold(
        appBar: AppBar(
          title: Text("Givin Pet"),
        ),
        body: ChangeNotifierProvider(
            builder: (_) => GivinPetProvider(),
            child: Consumer<GivinPetProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 15, right: 15),
                  child: StreamProvider<QuerySnapshot>.value(
                    value: value.fechPet(_user.email),
                    child: Consumer<QuerySnapshot>(
                      builder: (context, value, child) {
                        if (value == null)
                          return SpinKitRotatingCircle(
                            color: CustomColor.accentColor,
                            size: 50.0,
                          );

                        return CustomScrollView(slivers: <Widget>[
                          SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            delegate: SliverChildListDelegate(
                              [
                                if (value.documents.length > 0)
                                  ...value.documents
                                      .map((val) => BodyWidget(val, PetNavigator.editpet))
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
                );
              },
            )));
  }
}
