import 'dart:convert';

class Address {
  final String id;
  final String name;
  final String type;
  final String formattedAddress;
  Address({
    required this.id,
    required this.name,
    required this.type,
    required this.formattedAddress,
  });

  // Phương thức để chuyển đổi đối tượng JSON thành một đối tượng Address
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      formattedAddress: json['formattedAddress'] as String,
    );
  }

  // Phương thức để chuyển đổi một đối tượng Address thành một đối tượng JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'type': type,
      'formattedAddress': formattedAddress,
    };
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'type': type});
    result.addAll({'formattedAddress': formattedAddress});
  
    return result;
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      formattedAddress: map['formattedAddress'] ?? '',
    );
  }

 

  @override
  String toString() {
    return 'Address(id: $id, name: $name, type: $type, formattedAddress: $formattedAddress)';
  }
}
