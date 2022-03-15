import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:todo_mobx/core/app_theme/app_theme.dart';
import 'package:todo_mobx/core/consts/m_consts.dart';
import 'package:todo_mobx/core/keys/.env.dart';
import 'package:todo_mobx/generated/l10n.dart';
import 'package:todo_mobx/locator.dart';
import 'package:todo_mobx/presentation/logic/settings/index.dart';
import 'package:todo_mobx/presentation/screens/splash/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

late final AndroidNotificationChannel channel;
late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEkbCxwe4WH2wv5GzH7I9FUmwv7pWdhVw',
    appId: '1:936389769150:android:aa6effee221c9195616bef',
    messagingSenderId: '936389769150',
    projectId: 'todo-4b7b2',
    androidClientId:
        '936389769150-q2f26lh3qd9grs4qa9a367hv9805tbo3.apps.googleusercontent.com');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //init firebase messaging
  await Firebase.initializeApp(options: android);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //create android notification channel
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  const androidInitializeSettings =
  AndroidInitializationSettings('launch_background');
  const iosInitializationSettings = IOSInitializationSettings();
  const initializationSettings = InitializationSettings(
      android: androidInitializeSettings, iOS: iosInitializationSettings);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
    FirebaseMessaging.instance
        .getToken()
        .then((value) => print('fcm token: ${value}'));
    Future.microtask(() => _settingsStore.init());

    //
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _showModalForNotificationMessage(message);
      }
    });

    //
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background'
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
            ),
          ),
        );
      }
    });

    //
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });

    super.initState();
  }

  void _showModalForNotificationMessage(RemoteMessage message) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('notification title: ${message.notification?.title}'),
                Text('notification desc: ${message.notification?.body}'),
              ],
            ),
            height: 150,
          );
        });
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
