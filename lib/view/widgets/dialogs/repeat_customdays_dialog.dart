import 'dart:developer';

import '../../../controllers/repeat_task_controller.dart';
import '../constants/app_toast/rating_toast.dart';
import '../reuseable_imports/resueable_imports.dart';

class RepeatCustomDaysDialog extends StatefulWidget {
  const RepeatCustomDaysDialog({super.key});

  @override
  State<RepeatCustomDaysDialog> createState() => _RepeatCustomDaysDialogState();
}

class _RepeatCustomDaysDialogState extends State<RepeatCustomDaysDialog> {
  RepeatTaskController repeatTaskController = Get.put(RepeatTaskController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: AppColors.whiteColor,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          20.0.h.sh,
          Container(
            height: 370.h,
            color: Colors.transparent,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: repeatTaskController.days.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50.h,
                    // color: Colors.indigo,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40.h,
                          width: 150.w,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0.w),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  repeatTaskController.days[index].dayName,
                                  style: AllTextStyles.robotoRegular16(
                                      AppColors.blackColor)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0.w),
                          child: Checkbox(
                              activeColor: AppColors.primaryColor,
                              side: const BorderSide(
                                  color: AppColors.primaryColor),
                              value:
                                  repeatTaskController.days[index].isSelected,
                              onChanged: (value) {
                                setState(() {
                                  repeatTaskController.days[index].isSelected =
                                      value ?? false;
                                });
                              }),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UnFillButton(
                width: 90.w,
                height: 35.h,
                onTap: () {
                  Get.back();
                },
                textStyle:
                    AllTextStyles.robotoRegular16(AppColors.primaryColor),
                borderRadius: 10.r,
                text: 'Cancel',
              ),
              15.0.w.sw,
              FillButton(
                width: 90.w,
                height: 35.h,
                onTap: () {
                  final data = repeatTaskController.days
                      .where((p0) => p0.isSelected == true)
                      .toList();
                  if (data.isNotEmpty) {
                    repeatTaskController.repeatPattern.value =
                        repeatTaskController.days
                            .where((day) =>
                                day.isSelected) // Filter for selected days
                            .map((day) => day.dayName) // Extract titles
                            .join(","); // Join with commas
                    log("Selected Days String= =${repeatTaskController.repeatPattern.value}");
                    Get.back();
                  } else {
                    // Get.snackbar(
                    //   titleText: "Select At Least One", // Required text for title
                    //   messageText: "Alert One",
                    //   // Required text for message
                    // );
                  }
                },
                textStyle: AllTextStyles.robotoRegular16(AppColors.whiteColor),
                borderRadius: 10.r,
                text: 'Ok',
              ),
            ],
          ),
          20.0.sh,
        ],
      ),
    );
  }
}
