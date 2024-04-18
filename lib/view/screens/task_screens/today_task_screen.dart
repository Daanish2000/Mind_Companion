import 'dart:developer';

import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';

import '../../../controllers/db_controller/db_allmethod_controller.dart';
import '../../../controllers/edit_task_controller.dart';
import '../../../controllers/repeat_task_controller.dart';

class TodayTaskScreen extends StatefulWidget {
  const TodayTaskScreen({super.key});

  @override
  State<TodayTaskScreen> createState() => _TodayTaskScreenState();
}

class _TodayTaskScreenState extends State<TodayTaskScreen> {
  DBAllMethodController dbAllMethodController =
      Get.put(DBAllMethodController());
  EditTaskController editTaskController = Get.put(EditTaskController());
  RepeatTaskController repeatTaskController = Get.put(RepeatTaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        iconTheme: IconThemeData(color: AppColors.primaryColor, size: 30.sp),
        leading: GestureDetector(
          onTap: () {
            Get.offAllNamed(homeScreen);
          },
          child: Icon(
            size: 24.sp,
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          "Repeated Task",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.0.w),
          child: dbAllMethodController.allTasks.isEmpty
              ? Center(
                  child: Container(
                    child: Center(
                      child: Text(
                        "No Repeated Task Found",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    dbAllMethodController.updateToDoToInProgressTask();
                    setState(() {});
                  },
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: dbAllMethodController.allTasks.length,
                      itemBuilder: (context, index) {
                        var data = dbAllMethodController.allTasks[index];
                        log("ListView Date==${data.taskDate}");
                        if (data.isRepeated! || data.isInProgress! ?? false) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.0.h),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data.isRepeated!
                                          ? "Repeated"
                                          : data.isInProgress!
                                              ? "In Progress"
                                              : "Repeated.",
                                      style: AllTextStyles.robotoSemiBold10(
                                              AppColors.blackColor)
                                          .copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 6.0.w),
                                      child: Text(
                                        data.taskDate ?? "",
                                        style: AllTextStyles.robotoSemiBold10(
                                                AppColors.lightGrey)
                                            .copyWith(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                3.h.sh,
                                Container(
                                  height: 95.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: reuseAbleShadow,
                                      color: data.taskColor),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0.w, vertical: 10.0.h),
                                    child: Column(
                                      children: [
                                        5.h.sh,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 245.w,
                                              child: Text(
                                                data.taskTitle ?? "",
                                                style: AllTextStyles
                                                        .robotoSemiBold10(
                                                            AppColors
                                                                .blackColor)
                                                    .copyWith(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  if (data.isRepeated ??
                                                      false) {
                                                    repeatTaskController
                                                        .repeatTaskColor
                                                        .forEach((element) {
                                                      element.isSelected =
                                                          false;
                                                    });
                                                    repeatTaskController
                                                            .repeatTaskTitle
                                                            .text =
                                                        data.taskTitle ?? "";
                                                    repeatTaskController
                                                        .repeatTaskDescription
                                                        .text = data
                                                            .taskDescription ??
                                                        "";
                                                    repeatTaskController
                                                            .selectedTime
                                                            .value =
                                                        data.taskTime ?? "";
                                                    repeatTaskController
                                                            .selectedDate
                                                            .value =
                                                        data.taskDate ?? "";
                                                    repeatTaskController
                                                        .isRepeatedAudioSelected
                                                        .value = data
                                                            .isAudio ??
                                                        false;
                                                    repeatTaskController
                                                        .repeatedTaskId
                                                        .value = data.taskId!;
                                                    repeatTaskController
                                                            .isRepeatedCompleted
                                                            .value =
                                                        data.isCompleted ??
                                                            false;
                                                    repeatTaskController
                                                            .isRepeatedProgress
                                                            .value =
                                                        data.isInProgress ??
                                                            false;
                                                    repeatTaskController
                                                            .isRepeatedToDo
                                                            .value =
                                                        data.isInToDo ?? false;
                                                    repeatTaskController
                                                            .isRepeated.value =
                                                        data.isRepeated ??
                                                            false;
                                                    repeatTaskController
                                                            .repeatPattern
                                                            .value =
                                                        data.repeatPattern ??
                                                            "";
                                                    repeatTaskController
                                                        .repeatTaskColor
                                                        .forEach((element) {
                                                      if (element.circleColor ==
                                                          data.taskColor) {
                                                        element.isSelected =
                                                            true;
                                                      }
                                                    });
                                                    Get.toNamed(
                                                        editRepeatedTask,
                                                        arguments: false);
                                                  } else {
                                                    editTaskController
                                                        .editTaskColor
                                                        .forEach((element) {
                                                      element.isSelected =
                                                          false;
                                                    });

                                                    log("Task Id===${data.taskId}");
                                                    editTaskController
                                                            .editTaskTitle
                                                            .text =
                                                        data.taskTitle ?? "";
                                                    editTaskController
                                                            .editTaskDescription
                                                            .text =
                                                        data.taskDescription ??
                                                            "";
                                                    editTaskController
                                                            .selectedTime
                                                            .value =
                                                        data.taskTime ?? "";
                                                    editTaskController
                                                            .selectedDate
                                                            .value =
                                                        data.taskDate ?? "";
                                                    editTaskController
                                                            .isAudio.value =
                                                        data.isAudio ?? false;
                                                    editTaskController.taskId
                                                        .value = data.taskId!;
                                                    editTaskController
                                                            .isCompleted.value =
                                                        data.isCompleted ??
                                                            false;
                                                    editTaskController
                                                            .isInProgress
                                                            .value =
                                                        data.isInProgress ??
                                                            false;
                                                    editTaskController
                                                            .isToDo.value =
                                                        data.isInToDo ?? false;
                                                    editTaskController
                                                            .isRepeated.value =
                                                        data.isRepeated ??
                                                            false;
                                                    editTaskController
                                                            .editRepeatPattern
                                                            .value =
                                                        data.repeatPattern ??
                                                            "";
                                                    editTaskController
                                                        .editTaskColor
                                                        .forEach((element) {
                                                      if (element.circleColor ==
                                                          data.taskColor) {
                                                        element.isSelected =
                                                            true;
                                                      }
                                                    });
                                                    Get.offNamed(editTask);
                                                  }
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/edit.svg"))
                                          ],
                                        ),
                                        20.h.sh,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 245.w,
                                              child: Text(
                                                data.taskDescription ?? "",
                                                style: AllTextStyles
                                                        .robotoSemiBold10(
                                                            AppColors.blackColor
                                                                .withOpacity(
                                                                    0.8))
                                                    .copyWith(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 3.w),
                                              child: Text(
                                                data.taskTime ?? "",
                                                style: AllTextStyles
                                                        .robotoSemiBold10(
                                                            AppColors
                                                                .blackColor)
                                                    .copyWith(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                )),
    );
  }
}
