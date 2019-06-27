import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/add_provider.dart';
import 'package:pet_adoption/screens/addPetOne_screen.dart';
import 'package:pet_adoption/screens/addPetTwo_screen.dart';
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
                return PageView(
                  dragStartBehavior: DragStartBehavior.start,
                  pageSnapping: true,
                  children: <Widget>[
                    AddPetOneScreen(),
                    AddPetTwoScreen(),
                  ],
                );
              },
            )));
  }
}
