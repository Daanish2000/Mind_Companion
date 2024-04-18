import '../../../controllers/addnew_task_controller.dart';

import '../../widgets/constants/app_toast/rating_toast.dart';
import '../../widgets/reuseable_imports/resueable_imports.dart';
import '../../widgets/reuseable_textfield/description_reuseable_textfield.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addNewTaskController.selectedDate.value = DateTime.now().formattedDate();
      addNewTaskController.selectedTime.value =
          addNewTaskController.formatTimeOfDay(TimeOfDay.now());
    });
    setState(() {});

    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<FormState> addNewTaskKey = GlobalKey<FormState>();

  @override
  void dispose() {
    addNewTaskController.clearingAddNewTaskTextField();
    // TODO: implement dispose
    super.dispose();
  }

  AddNewTaskController addNewTaskController = Get.put(AddNewTaskController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "New Task",
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
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0.w),
              child: FillButton(
                  width: 70.w,
                  height: 30.w,
                  onTap: () {
                    if (addNewTaskController.taskTitle.text.isEmpty) {
                      showAccountToast(context, "Title is Empty");
                    } else if (addNewTaskController
                        .taskDescription.text.isEmpty) {
                      showAccountToast(context, "Description is Empty");
                    } else {
                      var selectedColor;
                      addNewTaskController.taskColor.forEach((element) {
                        if (element.isSelected) {
                          selectedColor = element.circleColor;
                        }
                      });
                      addNewTaskController.insertTask(
                          selectedColor ?? Colors.red,
                          addNewTaskController.isAudioSelected.value,
                          context);
                    }
                  },
                  textStyle:
                      AllTextStyles.robotoSemiBold12(AppColors.whiteColor)
                          .copyWith(fontSize: 10.sp),
                  borderRadius: 5.r,
                  text: "Save Task"),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Form(
            key: addNewTaskKey,
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
                SizedBox(
                  height: 70.h,
                  child: NormalTextField(
                      height: 65.h,
                      hintText: "Task title",
                      controller: addNewTaskController.taskTitle,
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
                            addNewTaskController.selectDate(context);
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
                                  child: Text(addNewTaskController.selectedDate
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
                            addNewTaskController.selectTime(context);
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
                                  child: Text(addNewTaskController
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
                  controller: addNewTaskController.taskDescription,
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
                          addNewTaskController.isAudioSelected.value = true;
                          // !addNewTaskController.isAudioSelected.value;
                        },
                        child: Container(
                          height: 40.h,
                          width: 145.w,
                          decoration: BoxDecoration(
                              color: AppColors.audioReminder,
                              border: Border.all(
                                  color:
                                      addNewTaskController.isAudioSelected.value
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
                          addNewTaskController.isAudioSelected.value = false;
                        },
                        child: Container(
                          height: 40.h,
                          width: 167.w,
                          decoration: BoxDecoration(
                              color: AppColors.notificationReminder,
                              border: Border.all(
                                  color: !addNewTaskController
                                          .isAudioSelected.value
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
                                //  SvgPicture.asset("assets/notification.svg"),
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
                      itemCount: addNewTaskController.taskColor.length,
                      itemBuilder: (context, index) {
                        var data = addNewTaskController.taskColor[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.0.w, vertical: 4.0.h),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                addNewTaskController.taskColor.forEach(
                                    (element) => element.isSelected = false);
                                addNewTaskController
                                        .taskColor[index].isSelected =
                                    !addNewTaskController
                                        .taskColor[index].isSelected;
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
                              child: addNewTaskController
                                      .taskColor[index].isSelected
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
