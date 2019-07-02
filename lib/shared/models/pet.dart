import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String aboutPet, addressShelter, genderPet, petName, typePet, docId;
  final int dateofbirth;
  final Map generalPetValues;
  final GeoPoint geoShelter;
  final List imageUrls;
  final bool isAdopted;

  Pet(
      {this.docId,
      this.aboutPet,
      this.addressShelter,
      this.genderPet,
      this.petName,
      this.typePet,
      this.dateofbirth,
      this.generalPetValues,
      this.geoShelter,
      this.imageUrls,
      this.isAdopted});

  factory Pet.fromMap(Map _map) {
    return Pet(
        docId: _map['docId'],
        aboutPet: _map['aboutPet'],
        addressShelter: _map['addressShelter'],
        dateofbirth: _map['dateofbirth'],
        genderPet: _map['genderPet'],
        generalPetValues: _map['generalPetValues'],
        geoShelter: _map['geoShelter'],
        imageUrls: _map['imageUrls'],
        isAdopted: _map['isAdopted'],
        petName: _map['petName'],
        typePet: _map['typePet']);
  }
}
