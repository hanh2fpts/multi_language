import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multi_language/l10n/multi_language.dart';
import 'package:multi_language/screens/home_page.dart';
import 'package:multi_language/utils/app_constants.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.changeLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale =
      const Locale.fromSubtags(languageCode: AppContants.languageCodeEN);
  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final multiLanguages = MultiLanguages();
    final localeKey = await multiLanguages.readLocaleKey();
    if (localeKey == AppContants.languageCodeEN) {
      _locale =
          const Locale(AppContants.languageCodeEN, AppContants.countryCodeEN);
    } else {
      _locale =
          const Locale.fromSubtags(languageCode: AppContants.languageCodeVI);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        supportedLocales: const [
          Locale(AppContants.languageCodeEN, AppContants.countryCodeEN),
          Locale(AppContants.languageCodeVI, AppContants.countryCodeVI),
        ],
        localizationsDelegates: const [
          MultiLanguages.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: _locale,
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocaleLanguage in supportedLocales) {
            if (supportedLocaleLanguage.languageCode == locale?.languageCode) {
              return supportedLocaleLanguage;
            }
          }
          return supportedLocales.first;
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo MultiLanguage'));
  }
}
