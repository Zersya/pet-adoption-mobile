import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/add_provider.dart';
import 'package:pet_adoption/providers/typeSelect_provider.dart';
import 'package:pet_adoption/screens/addPetOne_screen.dart';
import 'package:pet_adoption/screens/addPetTwo_screen.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Pet"),
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              builder: (_) => AddProvider(),
            ),
            ChangeNotifierProvider(
              builder: (_) => TypeSelectProvider(),
            )
          ],
          child: Consumer<AddProvider>(
            builder: (context, value, child) {
              return Stack(
                children: <Widget>[
                  PageView(
                    controller: value.pageController,
                    dragStartBehavior: DragStartBehavior.start,
                    pageSnapping: true,
                    children: <Widget>[
                      AddPetOneScreen(),
                      MultiProvider(providers: [
                        StreamProvider.value(
                          value: value.fetchGeneralPet(),
                        )
                      ], child: AddPetTwoScreen()),
                    ],
                  ),
                  if (value.stateAddPet == StateSubmit.isLoading)
                    CustomDialog(
                      child: SpinKitRotatingCircle(
                        color: CustomColor.accentColor,
                        size: 50.0,
                      ),
                    )
                  else if (value.stateAddPet == StateSubmit.Submited)
                    CustomDialog(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            MdiIcons.checkBold,
                            size: 42.0,
                            color: CustomColor.accentColor,
                          ),
                          SizedBox(height: 15.0),
                          Container(
                              child: Text("Berhasil Submit!",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: CustomColor.accentColor),
                                  textAlign: TextAlign.center)),
                        ],
                      ),
                    )
                ],
              );
            },
          ),
        ));
  }
}
