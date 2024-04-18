// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/setting_controller.dart';

import '../constants/app_toast/rating_toast.dart';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';

class OriginalRatingDialog extends StatefulWidget {
  const OriginalRatingDialog({super.key});

  @override
  State<OriginalRatingDialog> createState() => _OriginalRatingDialogState();
}

class _OriginalRatingDialogState extends State<OriginalRatingDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          25.0.h.sh,
          Text("Rate Us",
              style: AllTextStyles.robotoSemiBold25(AppColors.primaryColor)
                  .copyWith(
                fontSize: 25.sp,
              )),
          5.0.h.sh,
          Text(
            "Tap a star to set your rating",
            style: AllTextStyles.robotoMedium14(AppColors.lightGrey),
          ),
          25.0.h.sh,
          Wrap(children: [
            buildStar(1, context),
            buildStar(2, context),
            buildStar(3, context),
            buildStar(4, context),
            buildStar(5, context),
          ]),
          35.0.h.sh,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UnFillButton(
                    width: 75.w,
                    height: 38.h,
                    onTap: () {
                      if (settingController.rating.value == 0) {
                        showRatingToast(
                            context, "Please Select Atleast one Star");
                        Get.back();
                      } else {
                        Future.delayed(const Duration(milliseconds: 100),
                            () async {
                          if (settingController.rating.value > 3) {
                            settingController.openAppReview(true);
                            settingController.updateRating(0);
                          } else {
                            settingController.updateRatedValue(true);

                            showRatingToast(context, "Thanks For Your Rating");
                            settingController.updateRating(0);
                          }
                          Navigator.pop(context);
                        });
                        log('_rating');
                      }

                      //settingController.updateRating(starCount);

                      //  SystemNavigator.pop();
                    },
                    textStyle:
                        AllTextStyles.robotoMediumBold18(AppColors.primaryColor)
                            .copyWith(fontSize: 16.sp),
                    borderRadius: 10.r,
                    text: "Yes"),
                15.0.w.sw,
                FillButton(
                  width: 75.w,
                  height: 38.h,
                  onTap: () {
                    Navigator.pop(context);
                    settingController.updateRating(0);
                  },
                  textStyle: AllTextStyles.robotoMedium18(AppColors.whiteColor)
                      .copyWith(fontSize: 16.sp),
                  borderRadius: 10.r,
                  text: 'No',
                ),
              ],
            ),
          ),
          40.0.h.sh,
        ],
      ),
    );
  }
}

SettingController settingController = Get.put(SettingController());

Widget buildStar(
  int starCount,
  BuildContext context,
) {
  return Padding(
    padding: EdgeInsets.only(right: 8.w),
    child: Container(
      padding: EdgeInsets.zero,
      child: Obx(() => GestureDetector(
          onTap: () {
            settingController.updateRating(starCount);
            Future.delayed(const Duration(milliseconds: 100), () async {
              if (settingController.rating.value > 3) {
                // settingController.openAppReview(true);
                //  settingController.updateRating(0);
              } else {
                settingController.updateRatedValue(true);

                //showRatingToast(context, "Thanks For Your Rating");
                //settingController.updateRating(0);
              }
              // Navigator.pop(context);
            });
            log('_rating');
          },
          child: SvgPicture.asset(
            settingController.rating.value == 0
                ? "assets/rating_stars/unfill_stars.svg"
                : "assets/rating_stars/fillstars.svg",
            color: settingController.rating.value >= starCount
                ? AppColors.primaryColor
                : const Color(0xffCDCBCB),
            height: 30.h,
            width: 30.w,
          ))),
    ),
  );
}
