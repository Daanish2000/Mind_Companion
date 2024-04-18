import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../controllers/db_controller/db_allmethod_controller.dart';

class NotificationServices {
  DBAllMethodController dbAllMethodController =
      Get.put(DBAllMethodController());
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  void initializedNotifications() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
      dbAllMethodController.updateToDoToInProgressTask();
    });
  }

  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      "channelIdxxx", "channelNamex",
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      colorized: true,
      playSound: true,
      icon: "@mipmap/ic_launcher",
      largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
      styleInformation: BigTextStyleInformation(
          contentTitle: "Complete Your Task",
          "Lets Do It",
          htmlFormatBigText: true,
          htmlFormatContentTitle: true,
          htmlFormatContent: true,
          htmlFormatTitle: true));
  var androidPlatformChannelSpecifics1 = const AndroidNotificationDetails(
      "channelId", "channelName",
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      colorized: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      icon: "@mipmap/ic_launcher",
      largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
      styleInformation: BigTextStyleInformation(
          contentTitle: "Complete Your Task",
          "lets Do IT",
          htmlFormatBigText: true,
          htmlFormatContentTitle: true,
          htmlFormatContent: true,
          htmlFormatTitle: true));

  void scheduleNotification(String title, String body, var scheduledDateTime,
      int channelId, bool isAudio) async {
    log("Checking is Audio Value$isAudio");
    var platformChannelSpecifics;
    if (isAudio) {
      platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics1);
    } else {
      platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
    }
    await notificationsPlugin.zonedSchedule(
      channelId,
      title,
      body,
      scheduledDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      payload: "notification",
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void cancelNotification(int channelID) async {
    notificationsPlugin.cancel(channelID);
  }
}
