import 'dart:developer';

import 'package:mind_companion/controllers/db_controller/dbHelper.dart';
import 'package:mind_companion/controllers/repeat_task_controller.dart';
import 'package:mind_companion/view/screens/task_screens/your_task_screen.dart';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';

import '../../../controllers/db_controller/db_allmethod_controller.dart';
import '../../../controllers/edit_task_controller.dart';
import '../../../controllers/shared_prefrences/sharedpreferences.dart';
import '../../../model/localdb_models/addtask_model.dart';
import '../../widgets/dialogs/delete_dialog.dart';
import '../../widgets/notifications/notification.dart';
import '../../widgets/reuseable_textfield/description_reuseable_textfield.dart';
import 'package:timezone/timezone.dart' as tz;

class EditTask extends StatefulWidget {
  EditTask({
    super.key,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    setState(() {});

    // TODO: implement initState
    super.initState();
  }

  EditTaskController editTaskController = Get.put(EditTaskController());
  RepeatTaskController repeatTaskController = Get.put(RepeatTaskController());
  DBAllMethodController dbAllMethodController =
      Get.put(DBAllMethodController());
  @override
  void dispose() {
    editTaskController.clearingEditTaskTextField();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Task Details",
            style: AllTextStyles.robotoMedium16(AppColors.blackColor)
                .copyWith(fontSize: 18.sp),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
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
                      controller: editTaskController.editTaskTitle,
                      textColor: AppColors.lightGrey,
                      textStyle:
                          AllTextStyles.robotoMedium16(AppColors.blackColor)),
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
                          "Date",
                          style: AllTextStyles.robotoRegular14(
                              AppColors.blackColor),
                        ),
                        4.h.sh,
                        GestureDetector(
                          onTap: () {
                            editTaskController.selectDate(context);
                          },
                          child: Container(
                            height: 45.h,
                            width: 155.w,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Text(editTaskController.selectedDate
                                      .toString()),
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
                            editTaskController.selectTime(context);
                          },
                          child: Container(
                            height: 45.h,
                            width: 155.w,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0.w),
                                  child: Text(editTaskController
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
                  controller: editTaskController.editTaskDescription,
                  textColor: AppColors.lightGrey,
                  textStyle: AllTextStyles.robotoMedium16(AppColors.blackColor),
                ),
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
                          editTaskController.isAudio.value = true;
                        },
                        child: Container(
                          height: 40.h,
                          width: 145.w,
                          decoration: BoxDecoration(
                              color: AppColors.audioReminder,
                              border: Border.all(
                                  color: editTaskController.isAudio.value
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
                          editTaskController.isAudio.value = false;
                        },
                        child: Container(
                          height: 40.h,
                          width: 167.w,
                          decoration: BoxDecoration(
                              color: AppColors.notificationReminder,
                              border: Border.all(
                                  color: !editTaskController.isAudio.value
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
                      itemCount: editTaskController.editTaskColor.length,
                      itemBuilder: (context, index) {
                        var data = editTaskController.editTaskColor[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.0.w, vertical: 4.0.h),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                editTaskController.editTaskColor.forEach(
                                    (element) => element.isSelected = false);
                                editTaskController
                                        .editTaskColor[index].isSelected =
                                    !editTaskController
                                        .editTaskColor[index].isSelected;
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
                              child: editTaskController
                                      .editTaskColor[index].isSelected
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
                  children: [
                    editTaskController.isCompleted.value
                        ? SizedBox()
                        : FillButton(
                            width: 100.w,
                            height: 50.h,
                            onTap: () {
                              var selectedcolor;
                              editTaskController.editTaskColor
                                  .forEach((element) {
                                if (element.isSelected == true) {
                                  selectedcolor = element.circleColor;
                                }
                              });

                              DBHelper()
                                  .updateTask(AddTaskDBModel(
                                      taskId: editTaskController.taskId.value,
                                      taskTitle: editTaskController
                                          .editTaskTitle.value.text
                                          .toString(),
                                      taskDescription: editTaskController
                                          .editTaskDescription.text
                                          .toString(),
                                      taskDate:
                                          editTaskController.selectedDate.value,
                                      taskTime:
                                          editTaskController.selectedTime.value,
                                      taskColor: selectedcolor,
                                      isAudio: editTaskController.isAudio.value,
                                      isCompleted:
                                          editTaskController.isCompleted.value,
                                      isInProgress:
                                          editTaskController.isInProgress.value,
                                      isInToDo: editTaskController.isToDo.value,
                                      isRepeated: false,
                                      repeatPattern: editTaskController
                                          .editRepeatPattern.value))
                                  .then((value) {
                                log("Task Id==${editTaskController.taskId.value}");
                                log("Task Title==${editTaskController.editTaskTitle.value.text.toString()}");
                                log("Task Description==${editTaskController.editTaskDescription.text.toString()}");
                                log("Task IsCompleted==${editTaskController.isCompleted.value}");
                                log("Task isInProgress==${editTaskController.isInProgress.value}");
                                log("Task pattren==${editTaskController.editRepeatPattern.value}");
                                log("Successfully Updated$value");
                                var dateTime =
                                    AddTaskDBModel.isTaskDateTimePassed(
                                        editTaskController.selectedDate.value,
                                        editTaskController.selectedTime.value);

                                NotificationServices().cancelNotification(
                                    editTaskController.taskId.value);

                                tz.TZDateTime scheduledDateTime =
                                    dbAllMethodController
                                        .convertLocalToGlobalTime(
                                            editTaskController
                                                .selectedDate.value,
                                            editTaskController
                                                .selectedTime.value);

                                log("Time = = =$scheduledDateTime");
                                NotificationServices().scheduleNotification(
                                    editTaskController.editTaskTitle.value.text,
                                    editTaskController
                                        .editTaskDescription.value.text
                                        .toString(),
                                    scheduledDateTime,
                                    // time here to need to put
                                    editTaskController.taskId.value,
                                    editTaskController.isAudio.value);

                                dbAllMethodController.allTasks
                                    .forEach((element) {
                                  if (element.taskId ==
                                      editTaskController.taskId.value) {
                                    element.taskTitle = editTaskController
                                        .editTaskTitle.value.text
                                        .toString();
                                    element.taskDescription = editTaskController
                                        .editTaskDescription.value.text
                                        .toString();
                                    element.taskDate =
                                        editTaskController.selectedDate.value;
                                    element.taskTime =
                                        editTaskController.selectedTime.value;
                                    element.isAudio =
                                        editTaskController.isAudio.value;
                                    element.taskColor = selectedcolor;
                                    element.isInProgress =
                                        editTaskController.isInProgress.value;
                                    element.isInToDo =
                                        editTaskController.isToDo.value;
                                    element.isCompleted =
                                        editTaskController.isCompleted.value;
                                    element.isRepeated =
                                        editTaskController.isRepeated.value;
                                    element.isTimePassed = dateTime;
                                  } else {
                                    log("ID Not Found${editTaskController.taskId.value}");
                                  }
                                });

                                Get.off(const YourTaskScreen());
                              });
                            },
                            containerColor: AppColors.primaryColorLight,
                            textStyle: AllTextStyles.robotoSemiBold18(
                                    AppColors.blackColor)
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp),
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
                                return DeleteDialog(
                                  yes: () {
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

                                    NotificationServices().cancelNotification(
                                        editTaskController.taskId.value);

                                    log("TAsk id===${editTaskController.taskId.value}");
                                    DBHelper()
                                        .deleteTask(
                                            editTaskController.taskId.value)
                                        .then((value) {
                                      log("Successfully removed==$value");
                                      dbAllMethodController.allTasks
                                          .removeWhere((element) =>
                                              element.taskId ==
                                              editTaskController.taskId.value);
                                      NotificationServices().cancelNotification(
                                          editTaskController.taskId.value);
                                      Get.off(const YourTaskScreen());
                                    }).onError((error, stackTrace) {
                                      log("Error ==${error.toString()}");
                                    });
                                    // Get.back();
                                  },
                                  no: () {
                                    Get.back();
                                  },
                                );
                              });
                        },
                        containerColor: AppColors.deleteColor,
                        textStyle:
                            AllTextStyles.robotoSemiBold18(AppColors.blackColor)
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp),
                        borderRadius: 10.r,
                        text: "Delete"),
                    10.w.sw,
                    editTaskController.isCompleted.value
                        ? SizedBox()
                        : FillButton(
                            width: 100.w,
                            height: 50.h,
                            onTap: () {
                              var selectedcolor;
                              editTaskController.editTaskColor
                                  .forEach((element) {
                                if (element.isSelected == true) {
                                  selectedcolor = element.circleColor;
                                }
                              });

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

                              NotificationServices().cancelNotification(
                                  editTaskController.taskId.value);

                              DBHelper()
                                  .updateTask(AddTaskDBModel(
                                      taskId: editTaskController.taskId.value,
                                      taskTitle: editTaskController
                                          .editTaskTitle.value.text
                                          .toString(),
                                      taskDescription: editTaskController
                                          .editTaskDescription.text
                                          .toString(),
                                      taskDate:
                                          editTaskController.selectedDate.value,
                                      taskTime:
                                          editTaskController.selectedTime.value,
                                      taskColor: selectedcolor,
                                      isAudio: editTaskController.isAudio.value,
                                      isCompleted: true,
                                      isInProgress: false,
                                      isInToDo: false,
                                      isRepeated:
                                          editTaskController.isRepeated.value,
                                      repeatPattern: editTaskController
                                          .editRepeatPattern.value))
                                  .then((value) async {
                                log("Successfully Completed");
                                dbAllMethodController.allTasks
                                    .forEach((element) {
                                  if (element.taskId ==
                                      editTaskController.taskId.value) {
                                    element.taskTitle = editTaskController
                                        .editTaskTitle.value.text
                                        .toString();
                                    element.taskDescription = editTaskController
                                        .editTaskDescription.value.text
                                        .toString();
                                    element.taskDate =
                                        editTaskController.selectedDate.value;
                                    element.taskTime =
                                        editTaskController.selectedTime.value;
                                    element.isAudio =
                                        editTaskController.isAudio.value;
                                    element.taskColor = selectedcolor;
                                    element.isInProgress = false;

                                    element.isInToDo = false;
                                    element.isCompleted = true;
                                    element.isRepeated =
                                        editTaskController.isRepeated.value;
                                  }
                                });
                                NotificationServices().cancelNotification(
                                    editTaskController.taskId.value);

                                await Future.delayed(
                                    const Duration(microseconds: 10));
                                dbAllMethodController.allTasks.refresh();

                                Get.off(const YourTaskScreen());
                              });
                            },
                            containerColor: AppColors.primaryColorLight,
                            textStyle: AllTextStyles.robotoSemiBold18(
                                    AppColors.blackColor)
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp),
                            borderRadius: 10.r,
                            text: "Completed"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
