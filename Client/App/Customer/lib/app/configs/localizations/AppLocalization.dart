import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Hello',
    },
    'vn': {
      'title': 'Xin chào',
    },
  };

  String? get title {
    return _localizedValues[locale.languageCode]!['title'];
  }
}
