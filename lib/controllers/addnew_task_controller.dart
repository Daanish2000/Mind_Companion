import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:mind_companion/controllers/db_controller/dbHelper.dart';
import 'package:path/path.dart';

import '../model/localdb_models/addtask_model.dart';
import '../model/task_color_model.dart';
import '../view/widgets/constants/app_toast/rating_toast.dart';
import '../view/widgets/dialogs/saved_dialog.dart';
import '../view/widgets/notifications/notification.dart';
import '../view/widgets/reuseable_imports/resueable_imports.dart';
import 'db_controller/db_allmethod_controller.dart';
import 'package:timezone/timezone.dart' as tz;

class AddNewTaskController extends GetxController {
  DBAllMethodController dbAllMethodController =
      Get.put(DBAllMethodController());
  DBHelper dbHelper = DBHelper();
  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDate = TextEditingController();
  TextEditingController taskTime = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formatter = DateFormat('hh:mma');
    return formatter.format(dt);
  }

  RxBool isAudioSelected = false.obs;
  RxBool isLoadingInsert = false.obs;
//insert into DB:
  Future<void> insertTask(
      Color color, bool isAudio, BuildContext context) async {
    isLoadingInsert.value = true;
    await dbHelper
        .insertTask(AddTaskDBModel(
      taskTitle: taskTitle.text.trim().toString(),
      taskDescription: taskDescription.text.trim().toString(),
      taskDate: selectedDate.value,
      taskTime: selectedTime.value,
      taskColor: color,
      isAudio: isAudio,
      isCompleted: false,
      isInProgress: false,
      isInToDo: true,
      isRepeated: false,
      repeatPattern: '',
    ))
        .then((value) {
      var dateTime = AddTaskDBModel.isTaskDateTimePassed(
          selectedDate.value, selectedTime.value);

      tz.TZDateTime scheduledDateTime = dbAllMethodController
          .convertLocalToGlobalTime(selectedDate.value, selectedTime.value);

      log("Time = = =$scheduledDateTime");
      NotificationServices().scheduleNotification(
          taskTitle.text.trim().toString(),
          taskDescription.text.trim().toString(),
          scheduledDateTime,
          value,
          isAudio);

      dbAllMethodController.allTasks.insert(
          0,
          AddTaskDBModel(
              taskId: value,
              taskTitle: taskTitle.text.trim().toString(),
              taskDescription: taskDescription.text.trim().toString(),
              taskDate: selectedDate.value,
              taskTime: selectedTime.value,
              taskColor: color,
              isAudio: isAudio,
              isCompleted: false,
              isInProgress: false,
              isInToDo: true,
              isRepeated: false,
              isTimePassed: false,
              repeatPattern: ''));
      dbAllMethodController.allTasks
          .sort((a, b) => b.taskDate!.compareTo(a.taskDate ?? ""));
      dbAllMethodController.toDoTasks.refresh();
      dbAllMethodController.allTasks.refresh();
      isLoadingInsert.value = false;
      showDialog(
          context: context,
          builder: (context) {
            return SavedDialog(
              yes: () {
                clearingAddNewTaskTextField();
                Get.back();
                Get.offNamed(yourTask);

                //Get.offAllNamed(homeScreen);
              },
            );
          });
      log('Successfully Uploaded');
    }).onError((error, stackTrace) {
      showAccountToast(context, "Error Occurred");
      isLoadingInsert.value = false;
      log(error.toString());
    });
  }

  clearingAddNewTaskTextField() {
    taskTitle.clear();
    taskDate.clear();
    taskTime.clear();
    taskDescription.clear();
  }

  //Date Picker:
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
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
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      selectedDate.value = picked.formattedDate();

      log("Selected Date ===$selectedDate");
    }
  }

// Add this variable in your state class to store the selected date

  Rx<String> selectedDate = "".obs;
  Rx<String> selectedTime = "".obs;

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

  RxList<TaskColorModel> taskColor = <TaskColorModel>[
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
}
