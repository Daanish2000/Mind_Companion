import 'dart:developer';

import 'package:mind_companion/view/widgets/dialogs/repeat_customdays_dialog.dart';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';

import '../../../controllers/repeat_task_controller.dart';

class RepeatTaskDialog extends StatefulWidget {
  final VoidCallback ok;
  final VoidCallback cancel;
  RepeatTaskDialog({super.key, required this.ok, required this.cancel});

  @override
  State<RepeatTaskDialog> createState() => _RepeatTaskDialogState();
}

class _RepeatTaskDialogState extends State<RepeatTaskDialog> {
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
            height: 185.h,
            color: Colors.transparent,
            child: ListView.builder(
                itemCount: repeatTaskController.repeatSelection.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        repeatTaskController.trackIndex.value = index;
                        repeatTaskController.repeatSelection.forEach((element) {
                          element.isSelected = false;
                        });
                        repeatTaskController.repeatSelection[index].isSelected =
                            !repeatTaskController
                                .repeatSelection[index].isSelected;
                      });
                    },
                    child: Container(
                      height: 40.h,
                      width: double.maxFinite,
                      color:
                          repeatTaskController.repeatSelection[index].isSelected
                              ? AppColors.primaryColorLight
                              : AppColors.whiteColor,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              repeatTaskController.repeatSelection[index].title,
                              style: AllTextStyles.robotoRegular16(
                                  AppColors.blackColor)),
                        ),
                      ),
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
                  repeatTaskController.days.forEach((element) {
                    element.isSelected = false;
                  });
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
                  Navigator.pop(context);

                  if (repeatTaskController.trackIndex.value == 3) {
                    repeatTaskController.days.forEach((element) {
                      element.isSelected = false;
                    });
                    repeatTaskController.days.refresh();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const RepeatCustomDaysDialog();
                        });
                  } else {
                    if (repeatTaskController.trackIndex.value == 0) {
                      repeatTaskController.repeatPattern.value = "Once";
                    } else if (repeatTaskController.trackIndex.value == 1) {
                      repeatTaskController.repeatPattern.value = "Daily";
                    } else if (repeatTaskController.trackIndex.value == 2) {
                      repeatTaskController.repeatPattern.value =
                          "Mon,Tue,Wed,Thu,Fri";
                    }
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
