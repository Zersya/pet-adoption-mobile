import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pet_adoption/providers/typeSelect_provider.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/router.dart';
import 'package:pet_adoption/shared/widgets/imageSelect_container.dart';
import 'package:pet_adoption/shared/widgets/location_pick.dart';
import 'package:pet_adoption/shared/widgets/type_selection.dart';
import 'package:pet_adoption/providers/add_provider.dart';
import 'package:provider/provider.dart';

class AddPetOneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddProvider _addProvider = Provider.of<AddProvider>(context);
    TypeSelectProvider _typeSelectProvider =
        Provider.of<TypeSelectProvider>(context);

    String _datePicked;
    if (_addProvider.dateofBirth != null)
      _datePicked = _addProvider.dateofBirth.toLocal().day.toString() +
          "/" +
          _addProvider.dateofBirth.toLocal().month.toString() +
          "/" +
          _addProvider.dateofBirth.toLocal().year.toString();

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageSelect(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(height: 25.0, color: Colors.black87),
                LimitedBox(
                  maxHeight: 80,
                  child: StreamProvider<QuerySnapshot>.value(
                      value: _typeSelectProvider.fetchCategories(),
                      child: TypeSelection()),
                ),
                Divider(height: 25.0, color: Colors.black87),
                TextFormField(
                  controller: _addProvider.namePetController,
                  maxLength: 20,
                  validator: (val) {
                    if (val.isEmpty) return "Please Fill this field.";
                  },
                  decoration: InputDecoration(
                      hintText: "Pet Name",
                      filled: true,
                      fillColor: Colors.black12),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _addProvider.aboutPetController,
                  maxLength: 320,
                  minLines: 3,
                  maxLines: 5,
                  validator: (val) {
                    if (val.isEmpty) return "Please Fill this field.";
                  },
                  decoration: InputDecoration(
                      hintText: "About",
                      filled: true,
                      fillColor: Colors.black12),
                ),
                Text(
                  "Gender",
                  style: TextStyle(
                      color: CustomColor.accentColor,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      groupValue: _addProvider.genderPet,
                      value: "Boy",
                      onChanged: (val) => _addProvider.setGender(val),
                    ),
                    Text("Boy"),
                    Radio(
                      groupValue: _addProvider.genderPet,
                      value: "Girl",
                      onChanged: (val) => _addProvider.setGender(val),
                    ),
                    Text("Girl"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Date of birth",
                  style: TextStyle(
                      color: CustomColor.accentColor,
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: new DateTime.now(),
                        firstDate: new DateTime(2016),
                        lastDate: new DateTime.now());
                    _addProvider.setDateofBirth(picked);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _datePicked != null ? _datePicked : "Select date",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        Icon(
                          Icons.date_range,
                          color: CustomColor.accentColor,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Shelter",
                  style: TextStyle(
                      color: CustomColor.accentColor,
                      fontWeight: FontWeight.w600),
                ),
                Provider<String>.value(
                  value: _addProvider.address[0],
                  child: GestureDetector(
                      onTap: () async {
                        List<String> address = await Navigator.of(context)
                            .pushNamed(Router.mapPage) as List<String>;
                        _addProvider.setAddress(address);
                      },
                      child: LocationPick()),
                ),
                TextFormField(
                  controller: _addProvider.detailAddressController,
                  maxLength: 240,
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Detail Address",
                      filled: true,
                      fillColor: Colors.black12),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    color: CustomColor.accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    textColor: Colors.white,
                    child: Text("Next"),
                    onPressed: () {
                      _addProvider.pageController.nextPage(
                          curve: Curves.easeOut,
                          duration: Duration(milliseconds: 250));
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSelect extends StatelessWidget {
  const ImageSelect({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width / 1.5,
          child: ImageSelectContainer(
            index: 0,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 6,
                child: ImageSelectContainer(
                  index: 1,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 6,
                child: ImageSelectContainer(
                  index: 2,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
