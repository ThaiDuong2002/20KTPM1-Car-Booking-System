import 'dart:convert';

class Promotion {
   final String id;
  final String name;
  final String description;
  final double discount;
  final String startDate;
  final String endDate;
  final int usageLimit;
  Promotion({
    required this.id,
    required this.name,
    required this.description,
    required this.discount,
    required this.startDate,
    required this.endDate,
    required this.usageLimit,
  });

  @override
  String toString() {
    return 'Promotion(id: $id, name: $name, description: $description, discount: $discount, startDate: $startDate, endDate: $endDate, usageLimit: $usageLimit)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'discount': discount});
    result.addAll({'startDate': startDate});
    result.addAll({'endDate': endDate});
    result.addAll({'usageLimit': usageLimit});
  
    return result;
  }

  factory Promotion.fromMap(Map<String, dynamic> map) {
    return Promotion(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      discount: map['discount']?.toDouble() ?? 0.0,
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      usageLimit: map['usageLimit']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Promotion.fromJson(String source) => Promotion.fromMap(json.decode(source));
}
