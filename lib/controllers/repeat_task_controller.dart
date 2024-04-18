import 'dart:developer';

import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:mind_companion/controllers/db_controller/dbHelper.dart';
import 'package:mind_companion/controllers/shared_prefrences/sharedpreferences.dart';
import 'package:mind_companion/view/widgets/notifications/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/localdb_models/addtask_model.dart';
import '../model/repeat_task_models/daily_notification/daily_notifications.dart';
import '../model/repeat_task_models/repeat_task_days_model.dart';
import '../model/repeat_task_models/repeat_task_model.dart';
import '../model/task_color_model.dart';
import '../view/widgets/constants/app_toast/rating_toast.dart';
import '../view/widgets/dialogs/saved_dialog.dart';
import '../view/widgets/reuseable_imports/resueable_imports.dart';

import 'db_controller/db_allmethod_controller.dart';
import 'package:timezone/timezone.dart' as tz;

class RepeatTaskController extends GetxController {
  TextEditingController repeatTaskTitle = TextEditingController();

  TextEditingController repeatTaskDescription = TextEditingController();
  Rx<int> trackIndex = 0.obs;
  Rx<int> repeatedTaskId = 0.obs;
  RxBool isRepeatedAudioSelected = false.obs;
  RxBool isRepeatedCompleted = false.obs;
  RxBool isRepeatedProgress = false.obs;
  RxBool isRepeatedToDo = false.obs;
  RxBool isRepeated = false.obs;
  //List Of Repeated Task Selection:
  RxList<RepeatTaskModel> repeatSelection = [
    RepeatTaskModel(title: 'Once', isSelected: true),
    RepeatTaskModel(title: 'Daily', isSelected: false),
    RepeatTaskModel(title: 'Mon to Friday', isSelected: false),
    RepeatTaskModel(title: 'Custom', isSelected: false),
  ].obs;
  //List Of Days Task Selection:

  RxList<DaysModel> days = [
    DaysModel(dayName: 'Monday', isSelected: false),
    DaysModel(dayName: 'Tuesday', isSelected: false),
    DaysModel(dayName: 'Wednesday', isSelected: false),
    DaysModel(dayName: 'Thursday', isSelected: false),
    DaysModel(dayName: 'Friday', isSelected: false),
    DaysModel(dayName: 'Saturday', isSelected: false),
    DaysModel(dayName: 'Sunday', isSelected: false),
  ].obs;

//For ForMating Date Time In Usefully Format:
  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formatter = DateFormat('hh:mma');
    return formatter.format(dt);
  }

  //Clearing Fields:
  clearingEditTaskTextField() {
    repeatTaskTitle.clear();
    // selectedTime.value = "";
    selectedDate.value = "";
    repeatPattern.value = "Once";
    repeatTaskDescription.clear();
  }

  Rx<String> selectedTime = "".obs;
  Rx<String> selectedDate = "".obs;
  // Selecting Time:

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                AppColors.primaryColor, // Change the background color here
            // Change the color of the selected time
            colorScheme:
                const ColorScheme.light(primary: AppColors.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      selectedTime.value = formatTimeOfDay(picked);
    }
  }

  // Color Selection:
  RxList<TaskColorModel> repeatTaskColor = <TaskColorModel>[
    TaskColorModel(
        circleColor: const Color(0xffF6CDDB),
        circleBorderColor: const Color(0xffEFABC3),
        isSelected: true),
    TaskColorModel(
        circleColor: const Color(0xffE7D0EB),
        circleBorderColor: const Color(0xffD89EE3),
        isSelected: false),
    TaskColorModel(
        circleColor: const Color(0xffFBEFC9),
        circleBorderColor: const Color(0xffEAD490),
        isSelected: false),
    TaskColorModel(
        circleColor: const Color(0xffC8E6E3),
        circleBorderColor: const Color(0xff74BBB3),
        isSelected: false),
    TaskColorModel(
        circleColor: const Color(0xffD7EBD8),
        circleBorderColor: const Color(0xffAAD4AC),
        isSelected: false),
    TaskColorModel(
        circleColor: const Color(0xffCFE6F9),
        circleBorderColor: const Color(0xff9BBDD8),
        isSelected: false),
    TaskColorModel(
        circleColor: const Color(0xffDCE1E4),
        circleBorderColor: const Color(0xff9AB6C6),
        isSelected: false),
  ].obs;
  DBAllMethodController dbAllMethodController =
      Get.put(DBAllMethodController());
  DBHelper dbHelper = DBHelper();

  //Insert Repeated TasK::
  Rx<String> repeatPattern = "Once".obs;
  //Filtering Day Wise:

  DateTime getNextCustomDay(DateTime currentDate, String customDay) {
    int currentDay = currentDate.weekday;
    int targetDay = DateTime.monday; // Default to Monday (1)

    switch (customDay) {
      case 'monday':
        targetDay = DateTime.monday;
        break;
      case 'tuesday':
        targetDay = DateTime.tuesday;
        break;
      case 'wednesday':
        targetDay = DateTime.wednesday;
        break;
      case 'thursday':
        targetDay = DateTime.thursday;
        break;
      case 'friday':
        targetDay = DateTime.friday;
        break;
      case 'saturday':
        targetDay = DateTime.saturday;
        break;
      case 'sunday':
        targetDay = DateTime.sunday;
        break;
    }

    int daysToAdd = (targetDay - currentDay + 7) %
        7; // Calculate the days to add to reach the next custom day
    return currentDate.add(Duration(days: daysToAdd));
  }

// Filtering and Getting Notification Daily:
  Future<String> filterOutNotificationDaily(bool isAudio) async {
    List<String>? notificationId =
        SharedPrefs.preferences?.getStringList("${repeatedTaskId.value}");
    if (notificationId != null) {
      notificationId.forEach((element) {
        NotificationServices().cancelNotification(int.parse(element));
      });
      notificationId.clear();
      await SharedPrefs.preferences
          ?.setStringList("${repeatedTaskId.value}", notificationId);

      //later i will add new time notification:
      getNextDaysDaily();
      List<String> notificationIds =
          next30DaysDaily.map((task) => task.notificationRandomId).toList();

      await SharedPrefs.preferences
          ?.setStringList("${repeatedTaskId.value}", notificationIds);
      next30DaysDaily.forEach((element) {
        log("Sechedule Notification===${element.date}");
        NotificationServices().scheduleNotification(
            repeatTaskTitle.value.text,
            repeatTaskDescription.value.text,
            element.date,
            int.parse(element.notificationRandomId),
            isAudio);
      });
    } else {
      log("In Else Statement = =********* = = =");
      getNextDaysDaily();
      List<String> notificationIds =
          next30DaysDaily.map((task) => task.notificationRandomId).toList();

      await SharedPrefs.preferences
          ?.setStringList("${repeatedTaskId.value}", notificationIds);

      next30DaysDaily.forEach((element) {
        log("Sechedule Notification===${element.date}");
        NotificationServices().scheduleNotification(
            repeatTaskTitle.value.text,
            repeatTaskDescription.value.text,
            element.date,
            int.parse(element.notificationRandomId),
            isAudio);
      });
    }
    return next30DaysDaily.first.date.toString();
  }

// Filtering One Time :
  String filterOnce(bool isAudio) {
    String repeatDate = "";
    repeatDate = DateTime.now().formattedDate();

    tz.TZDateTime scheduledDateTime = dbAllMethodController
        .convertLocalToGlobalTime(repeatDate, selectedTime.value);
    NotificationServices().cancelNotification(repeatedTaskId.value);

    NotificationServices().scheduleNotification(
        repeatTaskTitle.value.text.toString(),
        repeatTaskDescription.value.text.toString(),
        scheduledDateTime,
        repeatedTaskId.value,
        isAudio);
    log("Repeated Task ID==${repeatedTaskId}");
    return repeatDate;
  }

  RxList<DailyNotificationsModel> next30DaysDaily =
      <DailyNotificationsModel>[].obs;
  RxList<DailyNotificationsModel> next30DaysMonToFri =
      <DailyNotificationsModel>[].obs;
  RxList<DailyNotificationsModel> next30DaysUserSelection =
      <DailyNotificationsModel>[].obs;

  // Filtering One Notification For 30 Days Later It Will Call For Other 30 Days:

  Future<String> filterOutNotificationMonToFriday(bool isAudio) async {
    List<String>? notificationId =
        SharedPrefs.preferences?.getStringList("${repeatedTaskId.value}");
    if (notificationId != null) {
      notificationId.forEach((element) {
        NotificationServices().cancelNotification(int.parse(element));
      });
      notificationId.clear();
      await SharedPrefs.preferences
          ?.setStringList("${repeatedTaskId.value}", notificationId);

      //later i will add new time notification:
      getNext30DaysMonToFriday("Mon,Fri");
      List<String> notificationIds =
          next30DaysMonToFri.map((task) => task.notificationRandomId).toList();

      await SharedPrefs.preferences
          ?.setStringList("${repeatedTaskId.value}", notificationIds);
      next30DaysMonToFri.forEach((element) {
        log("Sechedule Notification===${element.date}");
        NotificationServices().scheduleNotification(
            repeatTaskTitle.value.text,
            repeatTaskDescription.value.text,
            element.date,
            int.parse(element.notificationRandomId),
            isAudio);
      });
    } else {
      log("In Else Statement = =********* = = =");
      getNext30DaysMonToFriday("Mon,Fri");
      List<String> notificationIds =
          next30DaysMonToFri.map((task) => task.notificationRandomId).toList();

      await SharedPrefs.preferences
          ?.setStringList("${repeatedTaskId.value}", notificationIds);

      next30DaysMonToFri.forEach((element) {
        log("Sechedule Notification===${element.date}");
        NotificationServices().scheduleNotification(
            repeatTaskTitle.value.text,
            repeatTaskDescription.value.text,
            element.date,
            int.parse(element.notificationRandomId),
            isAudio);
      });
    }
    return next30DaysMonToFri.first.date.toString();
  }

  RxList<DailyNotificationsModel> getNextDaysDaily() {
    next30DaysDaily.clear();
    DateTime currentDate = DateTime.now();
    for (int i = 0; i < 30; i++) {
      DateTime nextDate =
          DateTime(currentDate.year, currentDate.month, currentDate.day + i);
      math.Random random = math.Random();
      int uniqueNotificationId = random.nextInt(50000000);
      String formattedDate = nextDate.formattedDate();
      tz.TZDateTime scheduledDateTime = dbAllMethodController
          .convertLocalToGlobalTime(formattedDate, selectedTime.value);
      next30DaysDaily.add(DailyNotificationsModel(
          date: scheduledDateTime,
          sqfLiteId: repeatedTaskId.value,
          notificationRandomId: uniqueNotificationId.toString()));
    }
    return next30DaysDaily;
  }

  List<DailyNotificationsModel> getNext30DaysMonToFriday(
      String repeatAlarmPattern) {
    next30DaysMonToFri.clear();
    DateTime currentDate = DateTime.now();
    while (next30DaysMonToFri.length < 30) {
      if (currentDate.weekday == DateTime.monday ||
          currentDate.weekday == DateTime.tuesday ||
          currentDate.weekday == DateTime.wednesday ||
          currentDate.weekday == DateTime.thursday ||
          currentDate.weekday == DateTime.friday) {
        log("Current Date===$currentDate");
        //
        math.Random random = math.Random();
        int notificationRandomIdFriToMon = random.nextInt(50000000);
        String formattedDate = currentDate.formattedDate();
        tz.TZDateTime scheduledDateTime = dbAllMethodController
            .convertLocalToGlobalTime(formattedDate, selectedTime.value);
        //
        next30DaysMonToFri.add(DailyNotificationsModel(
            date: scheduledDateTime,
            sqfLiteId: repeatedTaskId.value,
            notificationRandomId: notificationRandomIdFriToMon.toString()));
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return next30DaysMonToFri;
  }

  ///
  ///******************************=======================////

  List<DailyNotificationsModel> getNext30DaysUserSelection(
      String repeatPatterns) {
    try {
      next30DaysUserSelection.clear();
      DateTime currentDate = DateTime.now();

      List<String> selectedDays = repeatPatterns.split(",");
      Set<String> scheduledDates = {}; // Keep track of scheduled dates

      int daysAdded = 0;

      while (next30DaysUserSelection.length < 30) {
        DateTime nextDate = currentDate.add(Duration(days: daysAdded));
        String formattedDate = nextDate.formattedDate();
        String dayOfWeek = DateFormat('EEEE').format(nextDate);

        if (selectedDays.contains(dayOfWeek) &&
            !scheduledDates.contains(formattedDate)) {
          scheduledDates.add(formattedDate); // Add the date to scheduledDates

          // Generate notification for this date
          math.Random random = math.Random();
          int notificationRandomIdUserSelection = random.nextInt(50000000);
          tz.TZDateTime scheduledDateTime = dbAllMethodController
              .convertLocalToGlobalTime(formattedDate, selectedTime.value);
          next30DaysUserSelection.add(DailyNotificationsModel(
              date: scheduledDateTime,
              sqfLiteId: repeatedTaskId.value,
              notificationRandomId:
                  notificationRandomIdUserSelection.toString()));
        }

        daysAdded++;
        currentDate = nextDate;
      }
      next30DaysUserSelection.refresh();
    } catch (e) {
      log("Errrpor ==${e.toString()}");
    }
    return next30DaysUserSelection;
  }

  ///::*********** ::: *******************  ::: ********************** ///

  ///Filtering Out Notification For User Selection:
  Future<String> filterOutNotificationUserSelection(bool isAudio) async {
    List<String>? notificationId =
        SharedPrefs.preferences?.getStringList("${repeatedTaskId.value}");
    if (notificationId != null) {
      notificationId.forEach((element) {
        NotificationServices().cancelNotification(int.parse(element));
      });
      notificationId.clear();
      await SharedPrefs.preferences
          ?.setStringList("${repeatedTaskId.value}", notificationId);

      //later i will add new time notification:
      getNext30DaysUserSelection(repeatPattern.value);
      List<String> notificationIds = next30DaysUserSelection
          .map((task) => task.notificationRandomId)
          .toList();

      await SharedPrefs.preferences
          ?.setStringList("${repeatedTaskId.value}", notificationIds);
      next30DaysUserSelection.forEach((element) {
        log("Sechedule Notification===${element.date}");
        NotificationServices().scheduleNotification(
            repeatTaskTitle.value.text,
            repeatTaskDescription.value.text,
            element.date,
            int.parse(element.notificationRandomId),
            isAudio);
      });
    } else {
      log("In Else Statement = =********* = = =");
      getNext30DaysUserSelection(repeatPattern.value);
      List<String> notificationIds = next30DaysUserSelection
          .map((task) => task.notificationRandomId)
          .toList();

      await SharedPrefs.preferences
          ?.setStringList("${repeatedTaskId.value}", notificationIds);

      next30DaysUserSelection.forEach((element) {
        log("Sechedule Notification===${element.date}");
        NotificationServices().scheduleNotification(
            repeatTaskTitle.value.text,
            repeatTaskDescription.value.text,
            element.date,
            int.parse(element.notificationRandomId),
            isAudio);
      });
    }
    if (next30DaysUserSelection.isNotEmpty) {
      log("Lols====================");

      return next30DaysUserSelection.first.date.toString();
    } else {
      log("IN Else Case==========**************************====&&&&&&&&&&&&&&&&&&&&");
      return DateTime.now().formattedDate();
    }
  }

  ///

  Future<void> insertRepeatedTask(
      Color color, bool isAudio, BuildContext context) async {
    //

    log("Repeate Pattren==$repeatPattern");
    String repeatDate = DateTime.now().formattedDate();
    if (repeatPattern.contains("Once")) {
      repeatDate = DateTime.now().formattedDate();
    } else if (repeatPattern.contains("Daily")) {
      repeatDate = DateTime.now().formattedDate();
    } else if (repeatPattern.value == "Mon,Tue,Wed,Thu,Fri") {
      getNext30DaysMonToFriday("Mon,Fri");
      repeatDate = next30DaysMonToFri.first.date.toString();
      repeatDate = DateFormat('M/d/yyyy').format(DateTime.parse(repeatDate));

      log("InSerted Date==99=$repeatDate");
    } else {
      getNext30DaysUserSelection(repeatPattern.value);

      if (next30DaysUserSelection.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 1));
        repeatDate = next30DaysUserSelection.first.date.toString();
        repeatDate = DateFormat('M/d/yyyy').format(DateTime.parse(repeatDate));
        log("InSerted Date==99=$repeatDate");
        log("Else Case Testing= = 12345 = ");
      } else {
        log("***********==== Date IS PPPPPPPPP**************");
        repeatDate = DateTime.now().formattedDate();
        repeatDate = DateFormat('M/d/yyyy').format(DateTime.parse(repeatDate));
      }
    }

    await dbHelper
        .insertTask(AddTaskDBModel(
      taskTitle: repeatTaskTitle.text.trim().toString(),
      taskDescription: repeatTaskDescription.text.trim().toString(),
      taskDate: repeatDate,
      taskTime: selectedTime.value,
      taskColor: color,
      isAudio: isAudio,
      isCompleted: false,
      isInProgress: false,
      isInToDo: false,
      isRepeated: true,
      repeatPattern: repeatPattern.value,
    ))
        .then((value) async {
      repeatedTaskId.value = value;

      // String repeatDate = "";
      if (repeatPattern.contains("Once")) {
        // repeatDate =
        filterOnce(isAudio);
      } else if (repeatPattern.contains("Daily")) {
        // repeatDate =
        await filterOutNotificationDaily(isAudio);

        //  repeatDate = DateTime.now().formattedDate();
      } else if (repeatPattern.value == "Mon,Tue,Wed,Thu,Fri") {
        // repeatDate =
        await filterOutNotificationMonToFriday(isAudio);
        // repeatDate = next30DaysMonToFri.first.date.toString();
        // repeatDate = DateFormat('M/d/yyyy').format(DateTime.parse(repeatDate));
      } else {
        // repeatDate =
        await filterOutNotificationUserSelection(isAudio);

        // repeatDate = DateFormat('M/d/yyyy').format(DateTime.parse(repeatDate));
      }

      var dateTime = AddTaskDBModel.isTaskDateTimePassed(
          DateTime.now().formattedDate(), selectedTime.value);
      log("Ttile= * ==${repeatTaskTitle.text.trim().toString()}");
      log("Description == * =${repeatTaskDescription.text.trim().toString()}");
      log("Time= * ==$selectedTime");
      log("Date= * ==$repeatDate");
      log("Pattern== * =$repeatPattern");
      dbAllMethodController.allTasks.insert(
          0,
          AddTaskDBModel(
              taskId: value,
              taskTitle: repeatTaskTitle.text.trim().toString(),
              taskDescription: repeatTaskDescription.text.trim().toString(),
              taskDate: repeatDate,
              taskTime: selectedTime.value,
              taskColor: color,
              isAudio: isAudio,
              isCompleted: false,
              isInProgress: false,
              isInToDo: false,
              isRepeated: true,
              isTimePassed: dateTime,
              repeatPattern: repeatPattern.value));

      dbAllMethodController.allTasks.sort(
        (a, b) => b.taskDate!.compareTo(a.taskDate ?? ""),
      );
      dbAllMethodController.allTasks.refresh();

      showDialog(
          context: context,
          builder: (context) {
            return SavedDialog(
              yes: () {
                clearingEditTaskTextField();
                Get.offNamed(yourTask);

                //Get.offAllNamed(homeScreen);
              },
            );
          });
      log('Successfully Uploaded');

      log('Successfully Uploaded');
    }).onError((error, stackTrace) {
      log('Error =****** =${error.toString()}');
      showAccountToast(context, "Error Occurred");

      log(error.toString());
    });
  }
}
