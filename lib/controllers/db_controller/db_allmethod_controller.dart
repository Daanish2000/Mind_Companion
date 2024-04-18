import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mind_companion/controllers/db_controller/dbHelper.dart';
import '../../model/localdb_models/addtask_model.dart';
import '../../view/widgets/reuseable_imports/resueable_imports.dart';
import 'package:timezone/timezone.dart' as tz;

class DBAllMethodController extends GetxController {
  DBHelper dbHelper = DBHelper();
  RxList<AddTaskDBModel> allTasks = <AddTaskDBModel>[].obs;
  RxList<AddTaskDBModel> toDoTasks = <AddTaskDBModel>[].obs;
  RxList<AddTaskDBModel> progressTasks = <AddTaskDBModel>[].obs;
  RxList<AddTaskDBModel> completedTasks = <AddTaskDBModel>[].obs;
//Getting All Task
  Future<void> getAllTasks() async {
    allTasks.value = await dbHelper.getTaskListWithTaskId();

    allTasks.refresh();
    allTasks.forEach((element) {
      if (element.isCompleted == false) {
        if (element.isInProgress == false) {
          if (element.isTimePassed ?? false) {
            element.isInProgress = true;
            element.isInToDo = false;
            log("==========*********************======${element.isTimePassed}");
            DBHelper().updateTask(AddTaskDBModel(
                taskId: element.taskId,
                taskTitle: element.taskTitle,
                taskDescription: element.taskDescription,
                taskDate: element.taskDate,
                taskTime: element.taskTime,
                taskColor: element.taskColor,
                isAudio: element.isAudio,
                isCompleted: element.isCompleted,
                isInProgress: true,
                isInToDo: false,
                isRepeated: false,
                repeatPattern: element.repeatPattern));
          }
        } else {
          log("**********************************");
        }
      }

      log("Task Title==${element.taskTitle}");
      log("Task Task Date==${element.taskDate}");
      log("Task Task Time==${element.taskTime}");
      log("Task Task Time Combined==${element.isTimePassed}");
    });

    allTasks.refresh();
  }

  Rx<bool> isLoading = false.obs;

  //For Converting Local Time To Global Time That Work In All Country
  dynamic convertLocalToGlobalTime(
    String selectedDate,
    String selectedTime,
  ) {
    var userSelectedDateTime = "$selectedDate $selectedTime";
    log("UserSelectedDateTime= = = $userSelectedDateTime");
    DateFormat dateFormat = DateFormat("M/d/yyyy h:mma");
    DateTime userSelectedDateTimes = dateFormat.parse(userSelectedDateTime);

    tz.TZDateTime scheduledDateTime =
        tz.TZDateTime.from(userSelectedDateTimes, tz.local);
    return scheduledDateTime;
  }

//For Updating Task In PRogress
  updateToDoToInProgressTask() {
    allTasks.forEach((element) {
      if (element.isCompleted == false) {
        if (element.isInProgress == false) {
          bool isTimePasses = AddTaskDBModel.isTaskDateTimePassed(
              element.taskDate ?? "", element.taskTime ?? "");
          log("IsPassed==$isTimePasses");
          if (isTimePasses) {
            element.isTimePassed = isTimePasses;
            log("Truing The ");
            element.isInProgress = true;
            element.isInToDo = false;
          } else {
            // log("000000000000000000001");
          }
        } else {
          // log("000000000000000000002");
        }
      } else {
        // log("000000000000000000003");
      }
    });

    allTasks.refresh();
  }
  //Insert Data:
}
