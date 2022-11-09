import 'package:flutter/material.dart';
import 'package:multi_language/l10n/multi_language.dart';

class AppLanguagesDelegate extends LocalizationsDelegate<MultiLanguages> {
  // This delegate instance will never change
  // It can provide a constant constructor.
  const AppLanguagesDelegate();
  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'vi'].contains(locale.languageCode);
  }

  /// read Json
  @override
  Future<MultiLanguages> load(Locale locale) async {
    // MultiLanguages class is where the JSON loading actually runs

    MultiLanguages localizations = MultiLanguages(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLanguagesDelegate old) => false;
}
