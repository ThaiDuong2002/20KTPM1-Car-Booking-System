class ItemConfirmBooking {
  String pathIamge;
  String nameVihcle;
  String priceVihcle;
  String descriptionVihcle;
  ItemConfirmBooking({
    required this.pathIamge,
    required this.nameVihcle,
    required this.priceVihcle,
    required this.descriptionVihcle,
  });

  @override
  String toString() {
    return 'ItemConfirmBooking(pathIamge: $pathIamge, nameVihcle: $nameVihcle, priceVihcle: $priceVihcle, descriptionVihcle: $descriptionVihcle)';
  }
}
