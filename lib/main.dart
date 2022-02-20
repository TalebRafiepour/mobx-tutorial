import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_mobx/core/app_theme/app_theme.dart';
import 'package:todo_mobx/core/consts/m_consts.dart';
import 'package:todo_mobx/generated/l10n.dart';
import 'package:todo_mobx/locator.dart';
import 'package:todo_mobx/presentation/logic/settings/index.dart';
import 'package:todo_mobx/presentation/screens/splash/splash_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:todo_mobx/core/keys/.env.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final SettingsStore _settingsStore = locator.get<SettingsStore>();

  @override
  void initState() {
    Future.microtask(() => _settingsStore.init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.getTheme(_settingsStore.themeMode),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: MConstants.locales,
        locale: _settingsStore.selectedLocale,
        home: const SplashScreen(),
      );
    });
  }
}
