import 'dart:developer';

import 'package:intl/intl.dart';

import '../../../controllers/repeat_task_controller.dart';
import '../../widgets/constants/app_toast/rating_toast.dart';
import '../../widgets/dialogs/repeat_task_dialog.dart';
import '../../widgets/dialogs/saved_dialog.dart';
import '../../widgets/reuseable_imports/resueable_imports.dart';
import '../../widgets/reuseable_textfield/description_reuseable_textfield.dart';

class RepeatTask extends StatefulWidget {
  const RepeatTask({super.key});

  @override
  State<RepeatTask> createState() => _RepeatTaskState();
}

class _RepeatTaskState extends State<RepeatTask> {
  RepeatTaskController repeatTaskController = Get.put(RepeatTaskController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      repeatTaskController.selectedTime.value =
          repeatTaskController.formatTimeOfDay(TimeOfDay.now());
      repeatTaskController.repeatTaskTitle.clear();
      repeatTaskController.repeatTaskDescription.clear();
    });
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
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
          title: GestureDetector(
            onTap: () {
              // repeatTaskController.getNotificationDate();
            },
            child: Text(
              "Repeated Task",
              style: AllTextStyles.robotoMedium16(AppColors.blackColor)
                  .copyWith(fontSize: 18.sp),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0.w),
              child: FillButton(
                  width: 70.w,
                  height: 30.w,
                  onTap: () async {
                    if (repeatTaskController.repeatTaskTitle.text.isEmpty) {
                      showAccountToast(context, "Title is Empty");
                    } else if (repeatTaskController
                        .repeatTaskDescription.text.isEmpty) {
                      showAccountToast(context, "Description is Empty");
                    } else {
                      var selectedColor;
                      repeatTaskController.repeatTaskColor.forEach((element) {
                        if (element.isSelected) {
                          selectedColor = element.circleColor;
                        }
                      });

                      // repeatTaskController.repeatPattern
                      await repeatTaskController
                          .insertRepeatedTask(
                              selectedColor ?? Colors.red,
                              repeatTaskController
                                  .isRepeatedAudioSelected.value,
                              context)
                          .then((value) {
                        repeatTaskController.clearingEditTaskTextField();
                      });
                    }
                  },
                  textStyle:
                      AllTextStyles.robotoSemiBold12(AppColors.whiteColor)
                          .copyWith(fontSize: 10.sp),
                  borderRadius: 5.r,
                  text: "Save Task"),
            )
          ],
          leading: GestureDetector(
            onTap: () {
              repeatTaskController.clearingEditTaskTextField();
              repeatTaskController.days.forEach((element) {
                element.isSelected = false;
              });
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
                              border: Border.all(color: AppColors.primaryColor),
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
                              border: Border.all(color: AppColors.primaryColor),
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
                                fontSize: 14.sp, fontWeight: FontWeight.w500)),
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
                        var data = repeatTaskController.repeatTaskColor[index];
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
