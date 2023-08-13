import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage? of(BuildContext context) =>
      Localizations.of<BaseLanguage>(context, BaseLanguage);

  String get welcomeBack;

  String get signInYourAccount;
}
