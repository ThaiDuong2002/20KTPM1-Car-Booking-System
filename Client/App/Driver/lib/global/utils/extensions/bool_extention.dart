extension BooleanExtensions on bool? {
  bool validate({bool value = false}) => this ?? value;
}
