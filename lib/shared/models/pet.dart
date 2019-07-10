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

  Pet fromMap(Map _map) {

    
    return Pet(
        docId: _map['docId'] != null ? _map['docId'] : this.docId,
        aboutPet: _map['aboutPet'] != null ? _map['aboutPet'] : this.aboutPet,
        addressShelter: _map['addressShelter'] != null
            ? _map['addressShelter']
            : this.addressShelter,
        dateofbirth: _map['dateofbirth'] != null
            ? _map['dateofbirth']
            : this.dateofbirth,
        genderPet:
            _map['genderPet'] != null ? _map['genderPet'] : this.genderPet,
        generalPetValues: _map['generalPetValues'] != null
            ? _map['generalPetValues']
            : this.generalPetValues,
        geoShelter:
            _map['geoShelter'] != null ? _map['geoShelter'] : this.geoShelter,
        imageUrls:
            _map['imageUrls'] != null ? _map['imageUrls'] : this.imageUrls,
        isAdopted:
            _map['isAdopted'] != null ? _map['isAdopted'] : this.isAdopted,
        petName: _map['petName'] != null ? _map['petName'] : this.petName,
        typePet: _map['typePet'] != null ? _map['typePet'] : this.typePet);
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': this.docId,
      'aboutPet': this.aboutPet,
      'addressShelter': this.addressShelter,
      'dateofbirth': this.dateofbirth,
      'genderPet': this.genderPet,
      'generalPetValues': this.generalPetValues,
      'geoShelter': this.geoShelter,
      'imageUrls': this.imageUrls,
      'isAdopted': this.isAdopted,
      'petName': this.petName,
      'typePet': this.typePet
    };
  }
}
