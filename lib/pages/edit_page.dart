import 'package:flutter/material.dart';
import 'package:pet_adoption/providers/detail_provider.dart';
import 'package:pet_adoption/providers/givinPet_provider.dart';
import 'package:pet_adoption/screens/detail_screen.dart';
import 'package:pet_adoption/shared/custom_color.dart';
import 'package:pet_adoption/shared/enum.dart';
import 'package:pet_adoption/shared/models/pet.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final Pet pet;

  const EditPage({Key key, this.pet}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Pet")),
        body: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GivinPetProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailProvider(),
        )
      ],
      child: SingleChildScrollView(
              child: Container(
            child: Provider.value(
                value: widget.pet, child: DetailPetScreen(pet: widget.pet, editable: true,))),
      ),
    ));
  }
}

class NameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Pet _pet = Provider.of<Pet>(context);
    GivinPetProvider _provider = Provider.of<GivinPetProvider>(context);
    if (_provider.petModeEdit == PetModeEdit.isedit)
      return TextFormField(
        controller: TextEditingController(text: _pet.petName),
        maxLength: 20,
        validator: (val) {
          if (val.isEmpty) return "Please Fill this field.";
          return null;
        },
        decoration: InputDecoration(
            hintText: "Pet Name", filled: true, fillColor: Colors.black12),
      );
    if (_provider.petModeEdit == PetModeEdit.isview)
      return GestureDetector(
        onTap: () {
          _provider.setPetModeEdit(PetModeEdit.isedit);
        },
        child: Text(_pet.petName,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            )),
      );

      return Container();
  }
}

class TypeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Pet _pet = Provider.of<Pet>(context);
    GivinPetProvider _provider = Provider.of<GivinPetProvider>(context);
    if (_provider.petModeEdit == PetModeEdit.isedit)
      return TextFormField(
        controller: TextEditingController(text: _pet.typePet),
        maxLength: 20,
        validator: (val) {
          if (val.isEmpty) return "Please Fill this field.";
          return null;
        },
        decoration: InputDecoration(
            hintText: "Pet Type", filled: true, fillColor: Colors.black12),
      );
    if (_provider.petModeEdit == PetModeEdit.isview)
      return GestureDetector(
        onTap: () {
          _provider.setPetModeEdit(PetModeEdit.isedit);
        },
        child: Text(_pet.typePet,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            )),
      );

      return Container();
  }
}

class GenderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Pet _pet = Provider.of<Pet>(context);
    GivinPetProvider _provider = Provider.of<GivinPetProvider>(context);
    if (_provider.petModeEdit == PetModeEdit.isedit)
      return TextFormField(
        controller: TextEditingController(text: _pet.petName),
        maxLength: 20,
        validator: (val) {
          if (val.isEmpty) return "Please Fill this field.";
          return null;

        },
        decoration: InputDecoration(
            hintText: "Pet Name", filled: true, fillColor: Colors.black12),
      );
    if (_provider.petModeEdit == PetModeEdit.isview)
      return GestureDetector(
        onTap: () {
          _provider.setPetModeEdit(PetModeEdit.isedit);
        },
        child: Text(_pet.genderPet,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
      );
      return Container();

  }
}

class AddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Pet _pet = Provider.of<Pet>(context);
    GivinPetProvider _provider = Provider.of<GivinPetProvider>(context);
    if (_provider.petModeEdit == PetModeEdit.isedit)
      return TextFormField(
        controller: TextEditingController(text: _pet.addressShelter),
        maxLength: 20,
        validator: (val) {
          if (val.isEmpty) return "Please Fill this field.";
          return null;
        },
        decoration: InputDecoration(
            hintText: "Address shelter",
            filled: true,
            fillColor: Colors.black12),
      );
    if (_provider.petModeEdit == PetModeEdit.isview)
      return GestureDetector(
        onTap: () {
          _provider.setPetModeEdit(PetModeEdit.isedit);
        },
        child: Row(
          children: <Widget>[
            Icon(Icons.location_on, color: CustomColor.accentColor, size: 38),
            SizedBox(width: 24.0),
            Expanded(child: Text(_pet.addressShelter)),
          ],
        ),
      );
      return Container();

  }
}

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Pet _pet = Provider.of<Pet>(context);
    GivinPetProvider _provider = Provider.of<GivinPetProvider>(context);
    if (_provider.petModeEdit == PetModeEdit.isedit)
      return TextFormField(
        controller: TextEditingController(text: _pet.aboutPet),
        maxLength: 320,
        minLines: 3,
        maxLines: 5,
        validator: (val) {
          if (val.isEmpty) return "Please Fill this field.";
          return null;
        },
        decoration: InputDecoration(
            hintText: "About", filled: true, fillColor: Colors.black12),
      );
    if (_provider.petModeEdit == PetModeEdit.isview)
      return GestureDetector(
          onTap: () {
            _provider.setPetModeEdit(PetModeEdit.isedit);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("About",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_pet.aboutPet,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    )),
              ),
            ],
          ));
      return Container();

  }
}
