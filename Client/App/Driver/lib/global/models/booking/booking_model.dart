class BookingModel {
  final String userId;
  final String driverId;
  final String customerName;
  final String customerPhone;
  final String type;
  final String pickupAddress;
  final String destinationAddress;
  final String pickupTime;
  final String dropOffTime;
  final String createdAt;
  final String paymentMethodId;
  final String promotionId;
  final String status;
  final int total;
  final int distance;

  BookingModel(
    this.userId,
    this.driverId,
    this.customerName,
    this.customerPhone,
    this.type,
    this.pickupAddress,
    this.destinationAddress,
    this.pickupTime,
    this.dropOffTime,
    this.createdAt,
    this.paymentMethodId,
    this.promotionId,
    this.status,
    this.total,
    this.distance,
  );

  BookingModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        driverId = json['driverId'],
        customerName = json['customerName'],
        customerPhone = json['customerPhone'],
        type = json['type'],
        pickupAddress = json['pickupLocation']['address'],
        destinationAddress = json['destinationLocation']['address'],
        pickupTime = json['pickupTime'],
        dropOffTime = json['dropOffTime'],
        createdAt = json['createdAt'],
        paymentMethodId = json['paymentMethodId'],
        promotionId = json['promotionId'],
        status = json['status'],
        total = json['total'],
        distance = json['distance'];
}
