import 'package:driver/global/utils/constants/language.dart';
import 'package:driver/global/utils/extensions/string_extension.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';

class LanguageModel {
  int? id;
  String? name;
  String? languageCode;
  String? fullLanguageCode;
  String? flag;
  String? subTitle;

  LanguageModel({
    this.id,
    this.name,
    this.languageCode,
    this.flag,
    this.fullLanguageCode,
    this.subTitle,
  });

  static List<String> languages() {
    List<String> list = [];

    for (var element in localeLanguageList) {
      list.add(element.languageCode.validate());
    }

    return list;
  }

  static List<Locale> languageLocales() {
    List<Locale> list = [];

    for (var element in localeLanguageList) {
      list.add(Locale(element.languageCode.validate(), element.fullLanguageCode.validate()));
    }

    return list;
  }
}

LanguageModel? getSelectedLanguageModel({String? defaultLanguage}) {
  LanguageModel? data;

  for (var element in localeLanguageList) {
    if (element.languageCode == (sharedPref.getString(SELECTED_LANGUAGE_CODE) ?? defaultLanguage)) {
      data = element;
    }
  }

  return data;
}
