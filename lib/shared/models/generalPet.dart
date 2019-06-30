class GeneralPet {
  final name, color;

  GeneralPet(this.name, this.color);

  factory GeneralPet.fromQuery(var data) {
    return GeneralPet(data['name'], data['color']);
  }
}

class CustomDataColor {
  final int red, green, blue;
  final double alpha;

  CustomDataColor(this.red, this.green, this.blue, this.alpha);

  factory CustomDataColor.fromMap(Map _map) {
    return CustomDataColor(_map['red'], _map['green'], _map['blue'],
        _map['alpha'].toDouble());
  }
}
