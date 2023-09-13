class RatingModel {
  final String userId;
  final String driverId;
  final int star;
  final String createdAt;

  RatingModel(
    this.userId,
    this.driverId,
    this.star,
    this.createdAt,
  );

  RatingModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        driverId = json['driverId'],
        star = json['star'],
        createdAt = json['createdAt'];
}
