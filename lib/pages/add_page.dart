import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/add_provider.dart';
import 'package:pet_adoption/screens/addPetOne_screen.dart';
import 'package:pet_adoption/screens/addPetTwo_screen.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/widgets/imageSelect_container.dart';
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
        body: ChangeNotifierProvider(
            builder: (_) => AddProvider(),
            child: Consumer<AddProvider>(
              builder: (context, value, child) {
                List _general = ['Kindness', 'Healthy', 'Activity'];
                value.initGeneralPetValue(_general);

                return Stack(
                  children: <Widget>[
                    PageView(
                      controller: value.pageController,
                      dragStartBehavior: DragStartBehavior.start,
                      pageSnapping: true,
                      children: <Widget>[
                        AddPetOneScreen(),
                        AddPetTwoScreen(),
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
                        onTap: (){
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
            )));
  }
}

class CustomDialog extends StatelessWidget {
  final child, onTap;
  const CustomDialog({
    Key key,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: this.onTap,
          child: Container(
              decoration: BoxDecoration(
                color: CustomColor.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 2,
              child: this.child),
        ),
      ),
    );
  }
}
