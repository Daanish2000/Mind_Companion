import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_companion/view/widgets/constants/appcolors.dart';

class NormalTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color textColor;
  final TextStyle textStyle;
  final TextInputType keyboardType;
  final double width;
  final double height;

  NormalTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.textColor,
    required this.height,
    required this.textStyle,
    this.keyboardType = TextInputType.text,
    this.width = double.infinity, // Default value is set to take full width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45.h,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            log("Empty====");
            return 'Field Must Not be Empty';
          }
          return ""; // Validation passes
        },
        controller: controller,
        cursorColor: AppColors.primaryColor,
        keyboardType: keyboardType,
        style: textStyle.copyWith(color: textColor),
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: AppColors
                    .primaryColorLight), // Specify the color for the error border
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: AppColors
                    .primaryColorLight), // Specify the color for the error border
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: EdgeInsets.only(left: 10.w),
          hintText: hintText,
          hintStyle: textStyle.copyWith(color: textColor.withOpacity(0.5)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color:
                    AppColors.primaryColor), // Set the unfocused border color
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
