import 'package:timezone/timezone.dart' as tz;

//For Random Channel ID Making With MixUp PrimaryKey For Identification
class DailyNotificationsModel {
  tz.TZDateTime date;
  int sqfLiteId;
  String notificationRandomId;

  DailyNotificationsModel(
      {required this.date,
      required this.sqfLiteId,
      required this.notificationRandomId});
}
