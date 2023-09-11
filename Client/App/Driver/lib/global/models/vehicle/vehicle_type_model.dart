class VehicleTypeModel {
  final String _name;
  final int _capacity;

  VehicleTypeModel(this._name, this._capacity);

  String get name => _name;
  int get capacity => _capacity;

  set name(String name) => name = _name;
  set capacity(int capacity) => capacity = _capacity;

  VehicleTypeModel.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _capacity = json['capacity'];
}
