class PromotionModel {
  final String name;
  final String description;
  final double discount;
  final String startDate;
  final String endDate;
  final int usageLimit;

  PromotionModel(
    this.name,
    this.description,
    this.discount,
    this.startDate,
    this.endDate,
    this.usageLimit,
  );

  PromotionModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        discount = json['discount'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        usageLimit = json['usageLimit'];
}
