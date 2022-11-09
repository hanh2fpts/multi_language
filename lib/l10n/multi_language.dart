import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_language/app/app.dart';
import 'package:multi_language/l10n/multi_language_delegate.dart';
import 'package:multi_language/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiLanguages {
  final Locale locale;

  MultiLanguages(
      {this.locale =
          const Locale.fromSubtags(languageCode: AppContants.countryCodeEN)});

  static MultiLanguages? of(BuildContext context) {
    return Localizations.of<MultiLanguages>(context, MultiLanguages);
  }

  void keepLocalKey(String localKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppContants.localeKey);
    await prefs.setString(AppContants.localeKey, localKey);
  }

  //read sharedPreferences
  Future<String> readLocaleKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppContants.localeKey) ?? AppContants.countryCodeEN;
  }

  void setLocale(BuildContext context, Locale locale) async {
    keepLocalKey(locale.languageCode);
    MyApp.setLocale(context, locale);
  }

  static const LocalizationsDelegate<MultiLanguages> delegate =
      AppLanguagesDelegate();
  late Map<String, String> _localizedStrings;
  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key]!;
  }
}
