import 'package:flutter/material.dart';
import 'package:multi_language/l10n/multi_language.dart';
import 'package:multi_language/screens/setting_page.dart';
import 'package:multi_language/utils/app_constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  MultiLanguages multiLanguages = MultiLanguages();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Drawer')),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const SettingPage()));
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              MultiLanguages.of(context)!.translate('strTest'),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              if (await multiLanguages.readLocaleKey() ==
                  AppContants.languageCodeVI) {
                multiLanguages.setLocale(
                    context,
                    const Locale(
                        AppContants.languageCodeEN, AppContants.countryCodeEN));
              } else {
                multiLanguages.setLocale(
                    context,
                    const Locale(
                        AppContants.languageCodeVI, AppContants.countryCodeVI));
              }
            },
            child: const Icon(Icons.language_sharp),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
