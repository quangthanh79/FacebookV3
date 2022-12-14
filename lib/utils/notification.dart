import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
}

void selectNotification(String title, Map payload) async {
  print(payload);

  // navigatorKey.currentContext.handleNotificationClick(
  //     title,
  //     payload['link'],
  //     payload['schema'],
  //     int.parse(payload['linkId']),
  //     int.parse(payload['notificationId']));
}

showNotification(
    String title, String content, Map<String, dynamic> payload) async {
  content = content.replaceAll(r'\n', '\n');
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
  DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
      'com.vth.sweethome', 'MeetingMinutes Notification',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(''),
      ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin
      .show(0, title, content, platformChannelSpecifics, payload: "");
}