import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationProvider {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // initialize notification
  initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) {
      print('The payload is:::: $payload');
      return null;
    });
  }

  // show schedule
  showScheduleNotif({
    final String title,
    final String body,
    final DateTime time,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      '$title',
      '$body',
      time,
      platformChannelSpecifics,
      payload: 'item x',
      androidAllowWhileIdle: true,
    );
  }
}
