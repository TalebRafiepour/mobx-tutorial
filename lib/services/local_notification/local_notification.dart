import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const channelId = 'high_importance_channel'; // id
const channelName = 'High Importance Notifications';

class LocalNotification {
  LocalNotification._();

  factory LocalNotification() {
    _instance ??= LocalNotification._();
    return _instance!;
  }

  static LocalNotification? _instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    //create android notification channel
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      channelId, // id
      channelName, // title
      importance: Importance.high,
    );

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
  }

  void show(int id, String? title, String? body,
      NotificationDetails? notificationDetails,
      {String? payload}) {
    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);
  }
}

// flutterLocalNotificationsPlugin.show(
//   'notification'.hashCode,
//   'notification.title',
//   'notification.body',
//   NotificationDetails(
//     android: AndroidNotificationDetails(channel.id, channel.name,
//         icon: 'launch_background'
//         // TODO add a proper drawable resource to android, for now using
//         //      one that already exists in example app.
//         ),
//   ),
//);
