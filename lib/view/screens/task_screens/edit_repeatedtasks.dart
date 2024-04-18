import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:mind_companion/controllers/db_controller/db_allmethod_controller.dart';
import 'package:mind_companion/controllers/shared_prefrences/sharedpreferences.dart';
import 'package:mind_companion/view/screens/task_screens/today_task_screen.dart';
import 'package:mind_companion/view/screens/task_screens/your_task_screen.dart';
import 'package:mind_companion/view/widgets/dialogs/delete_dialog.dart';
import 'package:mind_companion/view/widgets/notifications/notification.dart';

import '../../../controllers/db_controller/dbHelper.dart';
import '../../../controllers/repeat_task_controller.dart';
import '../../../model/localdb_models/addtask_model.dart';
import '../../widgets/dialogs/repeat_task_dialog.dart';
import '../../widgets/reuseable_imports/resueable_imports.dart';
import '../../widgets/reuseable_textfield/description_reuseable_textfield.dart';

class EditRepeatedTask extends StatefulWidget {
  bool isFromYoursScreen;
  EditRepeatedTask({super.key, required this.isFromYoursScreen});

  @override
  State<EditRepeatedTask> createState() => _EditRepeatedTaskState();
}

class _EditRepeatedTaskState extends State<EditRepeatedTask> {
  RepeatTaskController repeatTaskController = Get.put(RepeatTaskController());
  DBAllMethodController dbAllMethodController =
      Get.put(DBAllMethodController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // repeatTaskController.selectedTime.value =
      //     repeatTaskController.formatTimeOfDay(TimeOfDay.now());
    });
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // repeatTaskController.clearingEditTaskTextField();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          log("Reatest cennj;/${widget.isFromYoursScreen}");
          // widget.isFromYoursScreen
          //     ? Get.offAllNamed(yourTask)
          //     : Get.offAllNamed(toDaysTask);
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Repeated Task",
              style: AllTextStyles.robotoMedium16(AppColors.blackColor)
                  .copyWith(fontSize: 18.sp),
            ),
            leading: GestureDetector(
              onTap: () {
                log("Repeat Bollean==${widget.isFromYoursScreen}");
                widget.isFromYoursScreen
                    ? Get.offAllNamed(yourTask)
                    : Get.offAllNamed(toDaysTask);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  15.h.sh,
                  Text(
                    "Task Title",
                    style: AllTextStyles.robotoRegular14(AppColors.blackColor),
                  ),
                  5.h.sh,
                  Container(
                    height: 70.h,
                    child: NormalTextField(
                        height: 65.h,
                        hintText: "Task title",
                        controller: repeatTaskController.repeatTaskTitle,
                        textColor: AppColors.lightGrey,
                        textStyle:
                            AllTextStyles.robotoMedium16(AppColors.blackColor)
                                .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500)),
                  ),
                  10.h.sh,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Repeat",
                            style: AllTextStyles.robotoRegular14(
                                AppColors.blackColor),
                          ),
                          4.h.sh,
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return RepeatTaskDialog(
                                      ok: () {},
                                      cancel: () {},
                                    );
                                  });
                              //repeatTaskController.selectDate(context);
                            },
                            child: Container(
                              height: 45.h,
                              width: 155.w,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: Text(
                                      repeatTaskController.repeatPattern.value,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      10.w.sw,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Time",
                            style: AllTextStyles.robotoRegular14(
                                AppColors.blackColor),
                          ),
                          4.h.sh,
                          GestureDetector(
                            onTap: () {
                              repeatTaskController.selectTime(context);
                            },
                            child: Container(
                              height: 45.h,
                              width: 155.w,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0.w),
                                    child: Text(repeatTaskController
                                        .selectedTime.value
                                        .toString()),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  10.h.sh,
                  Text(
                    "Task Description",
                    style: AllTextStyles.robotoRegular14(AppColors.blackColor),
                  ),
                  5.h.sh,
                  DescriptionTextField(
                      width: MediaQuery.sizeOf(context).width,
                      hintText: 'Description',
                      controller: repeatTaskController.repeatTaskDescription,
                      textColor: AppColors.lightGrey,
                      textStyle:
                          AllTextStyles.robotoMedium16(AppColors.blackColor)
                              .copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500)),
                  10.h.sh,
                  Text(
                    "Reminder",
                    style: AllTextStyles.robotoRegular14(AppColors.blackColor),
                  ),
                  5.h.sh,
                  Obx(
                    () => Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            repeatTaskController.isRepeatedAudioSelected.value =
                                true;
                          },
                          child: Container(
                            height: 40.h,
                            width: 145.w,
                            decoration: BoxDecoration(
                                color: AppColors.audioReminder,
                                border: Border.all(
                                    color: repeatTaskController
                                            .isRepeatedAudioSelected.value
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                    width: 2.w),
                                borderRadius: BorderRadius.circular(
                                  6.r,
                                )),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SvgPicture.asset("assets/audio.svg"),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Center(
                                      child: Text(
                                    "Audio Reminder",
                                    style: AllTextStyles.robotoSemiBold12(
                                        AppColors.whiteColor),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        8.w.sw,
                        GestureDetector(
                          onTap: () {
                            repeatTaskController.isRepeatedAudioSelected.value =
                                false;
                          },
                          child: Container(
                            height: 40.h,
                            width: 167.w,
                            decoration: BoxDecoration(
                                color: AppColors.notificationReminder,
                                border: Border.all(
                                    color: !repeatTaskController
                                            .isRepeatedAudioSelected.value
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                    width: 1.5.w),
                                borderRadius: BorderRadius.circular(
                                  6.r,
                                )),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  //SvgPicture.asset("assets/notification.svg"),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Center(
                                      child: Text(
                                    "Notification Reminder",
                                    style: AllTextStyles.robotoSemiBold12(
                                        AppColors.whiteColor),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.h.sh,
                  Text(
                    "Color",
                    style: AllTextStyles.robotoRegular14(AppColors.blackColor),
                  ),
                  5.h.sh,
                  Container(
                    height: 50.h,
                    color: Colors.white,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: repeatTaskController.repeatTaskColor.length,
                        itemBuilder: (context, index) {
                          var data =
                              repeatTaskController.repeatTaskColor[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.0.w, vertical: 4.0.h),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  repeatTaskController.repeatTaskColor.forEach(
                                      (element) => element.isSelected = false);
                                  repeatTaskController
                                          .repeatTaskColor[index].isSelected =
                                      !repeatTaskController
                                          .repeatTaskColor[index].isSelected;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: data.circleColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: data.circleBorderColor,
                                      width: 1.5.w,
                                    )),
                                height: 40.h,
                                width: 40.w,
                                child: repeatTaskController
                                        .repeatTaskColor[index].isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                          );
                        }),
                  ),
                  30.h.sh,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FillButton(
                          width: 100.w,
                          height: 50.h,
                          onTap: () async {
                            log("Repeat Patteren===${repeatTaskController.repeatPattern}");
                            var selectedcolor;
                            repeatTaskController.repeatTaskColor
                                .forEach((element) {
                              if (element.isSelected == true) {
                                selectedcolor = element.circleColor;
                              }
                            });
                            if (repeatTaskController.repeatPattern.value ==
                                    "Once" ||
                                repeatTaskController.repeatPattern.value ==
                                    "Daily") {
                              NotificationServices().cancelNotification(
                                  repeatTaskController.repeatedTaskId.value);
                            }

                            ///
                            try {
                              log("Repeate Pattren==${repeatTaskController.repeatPattern}");
                              String repeatDate = "";
                              if (repeatTaskController.repeatPattern
                                  .contains("Once")) {
                                repeatDate = repeatTaskController.filterOnce(
                                    repeatTaskController
                                        .isRepeatedAudioSelected.value);
                              } else if (repeatTaskController.repeatPattern
                                  .contains("Daily")) {
                                log("InDaily====");
                                repeatDate = await repeatTaskController
                                    .filterOutNotificationDaily(
                                        repeatTaskController
                                            .isRepeatedAudioSelected.value);
                                DateTime dateTime =
                                    DateTime.parse(repeatDate).toLocal();
                                repeatDate = dateTime.formattedDate();
                                log("Date Parsing Now ==$repeatDate");
                              } else if (repeatTaskController
                                      .repeatPattern.value ==
                                  "Mon,Tue,Wed,Thu,Fri") {
                                repeatDate = await repeatTaskController
                                    .filterOutNotificationMonToFriday(
                                        repeatTaskController
                                            .isRepeatedAudioSelected.value);
                                DateTime dateTime = DateTime.parse(repeatDate);
                                repeatDate = dateTime.formattedDate();
                                log("Date Parsing Now ==$repeatDate");
                              } else {
                                repeatDate = await repeatTaskController
                                    .filterOutNotificationUserSelection(
                                        repeatTaskController
                                            .isRepeatedAudioSelected.value);
                                DateTime dateTime = DateTime.parse(repeatDate);
                                repeatDate = dateTime.formattedDate();
                                log("Date Parsing Now ==$repeatDate");
                              }
                              DBHelper()
                                  .updateTask(AddTaskDBModel(
                                      taskId: repeatTaskController
                                          .repeatedTaskId.value,
                                      taskTitle: repeatTaskController
                                          .repeatTaskTitle.value.text
                                          .toString(),
                                      taskDescription: repeatTaskController
                                          .repeatTaskDescription.text
                                          .toString(),
                                      taskDate: repeatDate,
                                      // repeatTaskController.selectedDate.value,
                                      taskTime: repeatTaskController
                                          .selectedTime.value,
                                      taskColor: selectedcolor,
                                      isAudio: repeatTaskController
                                          .isRepeatedAudioSelected.value,
                                      isCompleted: repeatTaskController
                                          .isRepeatedCompleted.value,
                                      isInProgress: repeatTaskController
                                          .isRepeatedProgress.value,
                                      isInToDo: repeatTaskController
                                          .isRepeatedToDo.value,
                                      isRepeated:
                                          repeatTaskController.isRepeated.value,
                                      repeatPattern: repeatTaskController
                                          .repeatPattern.value))
                                  .then((value) async {
                                log("Successfully Updated");
                                dbAllMethodController.allTasks
                                    .forEach((element) {
                                  if (element.taskId ==
                                      repeatTaskController
                                          .repeatedTaskId.value) {
                                    element.taskTitle = repeatTaskController
                                        .repeatTaskTitle.value.text
                                        .toString();
                                    element.taskDescription =
                                        repeatTaskController
                                            .repeatTaskDescription.value.text
                                            .toString();
                                    element.taskDate = repeatDate;
                                    //  repeatTaskController.selectedDate.value;
                                    element.taskTime =
                                        repeatTaskController.selectedTime.value;
                                    element.isAudio = repeatTaskController
                                        .isRepeatedAudioSelected.value;
                                    element.taskColor = selectedcolor;
                                    element.isInProgress = repeatTaskController
                                        .isRepeatedProgress.value;
                                    element.isInToDo = repeatTaskController
                                        .isRepeatedToDo.value;
                                    element.isCompleted = repeatTaskController
                                        .isRepeatedCompleted.value;
                                    element.isRepeated =
                                        repeatTaskController.isRepeated.value;
                                  } else {
                                    log("Id Not Found=${element.taskId}");
                                  }
                                });
                                dbAllMethodController.allTasks.refresh();
                                await Future.delayed(
                                    const Duration(microseconds: 1));
                                Get.off(const TodayTaskScreen());
                              });
                            } catch (e) {
                              log("Error Comes${e.toString()}");
                            }
                          },
                          containerColor: AppColors.primaryColorLight,
                          textStyle: AllTextStyles.robotoSemiBold18(
                                  AppColors.blackColor)
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16.sp),
                          borderRadius: 10.r,
                          text: "Update"),
                      10.w.sw,
                      FillButton(
                          width: 100.w,
                          height: 50.h,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return DeleteDialog(yes: () async {
                                    log("Repeate Pattren id===${repeatTaskController.repeatPattern}");
                                    log("TAsk id===${repeatTaskController.repeatedTaskId.value}");

                                    List<String>? notificationIds =
                                        SharedPrefs.preferences?.getStringList(
                                                "${repeatTaskController.repeatedTaskId.value}") ??
                                            [];
                                    if (notificationIds.isNotEmpty) {
                                      notificationIds.forEach((element) {
                                        NotificationServices()
                                            .cancelNotification(
                                                int.parse(element));
                                      });
                                    }
                                    if (repeatTaskController
                                                .repeatPattern.value ==
                                            "Once" ||
                                        repeatTaskController
                                                .repeatPattern.value ==
                                            "Daily") {
                                      log("IN Once Daily in Delete REpreta************************");
                                      log("Notificstion If ===${repeatTaskController.repeatedTaskId.value}");
                                      NotificationServices().cancelNotification(
                                          repeatTaskController
                                              .repeatedTaskId.value);
                                    }

                                    DBHelper()
                                        .deleteTask(repeatTaskController
                                            .repeatedTaskId.value)
                                        .then((value) {
                                      log("Successfully removed==$value");
                                      dbAllMethodController.allTasks
                                          .removeWhere((element) =>
                                              element.taskId ==
                                              repeatTaskController
                                                  .repeatedTaskId.value);
                                      Get.off(const TodayTaskScreen());
                                    }).onError((error, stackTrace) {
                                      log("Error ==${error.toString()}");
                                    });
                                    // Get.back();
                                  }, no: () {
                                    Get.back();
                                  });
                                });
                          },
                          containerColor: AppColors.deleteColor,
                          textStyle: AllTextStyles.robotoSemiBold18(
                                  AppColors.blackColor)
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16.sp),
                          borderRadius: 10.r,
                          text: "Delete"),
                      10.w.sw,
                      FillButton(
                          width: 100.w,
                          height: 50.h,
                          onTap: () async {
                            var selectedcolor;
                            repeatTaskController.repeatTaskColor
                                .forEach((element) {
                              if (element.isSelected == true) {
                                selectedcolor = element.circleColor;
                              }
                            });
                            try {
                              List<String>? notificationIds =
                                  SharedPrefs.preferences?.getStringList(
                                          "${repeatTaskController.repeatedTaskId.value}") ??
                                      [];
                              if (notificationIds.isNotEmpty) {
                                notificationIds.forEach((element) {
                                  NotificationServices()
                                      .cancelNotification(int.parse(element));
                                });
                              }
                              if (repeatTaskController.repeatPattern.value ==
                                      "Once" ||
                                  repeatTaskController.repeatPattern.value ==
                                      "Daily") {
                                log("in Once or Daily");
                                NotificationServices().cancelNotification(
                                    repeatTaskController.repeatedTaskId.value);
                              }

                              DBHelper()
                                  .updateTask(AddTaskDBModel(
                                      taskId: repeatTaskController
                                          .repeatedTaskId.value,
                                      taskTitle: repeatTaskController
                                          .repeatTaskTitle.value.text
                                          .toString(),
                                      taskDescription: repeatTaskController
                                          .repeatTaskDescription.text
                                          .toString(),
                                      taskDate: repeatTaskController
                                          .selectedDate.value,
                                      taskTime: repeatTaskController
                                          .selectedTime.value,
                                      taskColor: selectedcolor,
                                      isAudio: repeatTaskController
                                          .isRepeatedAudioSelected.value,
                                      isCompleted: true,
                                      isInProgress: false,
                                      isInToDo: false,
                                      isRepeated: false,
                                      repeatPattern: repeatTaskController
                                          .repeatPattern.value))
                                  .then((value) async {
                                var dateTime =
                                    AddTaskDBModel.isTaskDateTimePassed(
                                        repeatTaskController.selectedDate.value,
                                        repeatTaskController
                                            .selectedTime.value);

                                log("Successfully Updated");
                                dbAllMethodController.allTasks
                                    .forEach((element) {
                                  if (element.taskId ==
                                      repeatTaskController
                                          .repeatedTaskId.value) {
                                    element.taskTitle = repeatTaskController
                                        .repeatTaskTitle.value.text
                                        .toString();
                                    element.taskDescription =
                                        repeatTaskController
                                            .repeatTaskDescription.value.text
                                            .toString();
                                    element.taskDate =
                                        repeatTaskController.selectedDate.value;
                                    element.taskTime =
                                        repeatTaskController.selectedTime.value;
                                    element.isAudio = repeatTaskController
                                        .isRepeatedAudioSelected.value;
                                    element.taskColor = selectedcolor;
                                    element.isInProgress = false;
                                    element.isInToDo = false;
                                    element.isCompleted = true;
                                    element.isRepeated = false;
                                    element.isTimePassed = dateTime;
                                  } else {
                                    log("Id Not Found=${element.taskId}");
                                  }
                                });
                                dbAllMethodController.allTasks.refresh();
                                await Future.delayed(
                                    const Duration(microseconds: 1));
                                Get.off(const TodayTaskScreen());
                              });
                            } catch (e) {
                              log("Error Comes${e.toString()}");
                            }
                          },
                          containerColor: AppColors.primaryColorLight,
                          textStyle: AllTextStyles.robotoSemiBold18(
                                  AppColors.blackColor)
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16.sp),
                          borderRadius: 10.r,
                          text: "Completed"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
