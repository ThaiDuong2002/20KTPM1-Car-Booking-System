class ItemConfirmBooking {
  String pathIamge;
  String nameVihcle;
  String priceVihcle;
  String descriptionVihcle;
  double promotionDiscountVihcle;
  ItemConfirmBooking({
    required this.pathIamge,
    required this.nameVihcle,
    required this.priceVihcle,
    required this.descriptionVihcle,
    required this.promotionDiscountVihcle,
  });
  

  @override
  String toString() {
    return 'ItemConfirmBooking(pathIamge: $pathIamge, nameVihcle: $nameVihcle, priceVihcle: $priceVihcle, descriptionVihcle: $descriptionVihcle, promotionDiscountVihcle: $promotionDiscountVihcle)';
  }
}
