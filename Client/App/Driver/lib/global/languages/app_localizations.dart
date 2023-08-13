import 'package:driver/global/languages/base_language.dart';
import 'package:driver/global/languages/language_en.dart';
import 'package:driver/global/languages/language_vi.dart';
import 'package:driver/global/models/language/language_model.dart';
import 'package:flutter/material.dart';

class AppLocalizations extends LocalizationsDelegate<BaseLanguage> {
  const AppLocalizations();

  @override
  Future<BaseLanguage> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'vi':
        return LanguageVi();
      default:
        return LanguageEn();
    }
  }

  @override
  bool isSupported(Locale locale) => LanguageModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<BaseLanguage> old) => false;
}