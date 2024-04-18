import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mind_companion/view/widgets/constants/appcolors.dart';

import '../../../controllers/signup_controller.dart';

class FillButton extends StatelessWidget {
  double height;
  double width;
  double borderRadius;
  VoidCallback onTap;
  TextStyle textStyle;
  Color containerColor;

  String text;

  FillButton(
      {super.key,
      required this.width,
      required this.height,
      required this.onTap,
      required this.textStyle,
      required this.borderRadius,
      this.containerColor = AppColors.primaryColor,
      required this.text});
  SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(borderRadius)),
          child: signUpController.isLoading.value
              ? Center(
                  child: SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: const CircularProgressIndicator(
                    backgroundColor: AppColors.whiteColor,
                    color: AppColors.primaryColor,
                  ),
                ))
              : Center(
                  child: Text(
                  text,
                  style: textStyle,
                )),
        ),
      ),
    );
  }
}
