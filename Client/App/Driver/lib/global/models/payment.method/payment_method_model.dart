class PaymentMethodModel {
  final String name;

  PaymentMethodModel({required this.name});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) : name = json['name'];
}
