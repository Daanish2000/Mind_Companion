import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_companion/view/widgets/constants/appcolors.dart';

class DescriptionTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color textColor;
  final TextStyle textStyle;
  final TextInputType keyboardType;
  final double width;

  DescriptionTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.textColor,
    required this.textStyle,
    this.keyboardType = TextInputType.text,
    this.width = double.infinity, // Default value is set to take full width
  });
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 150.h,
      color: Colors.transparent,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            log("Empty====");
            return 'Description is Empty';
          }
          return null; // Validation passes
        },
        cursorColor: AppColors.primaryColor,
        maxLines: 6,
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
          hintText: hintText,
          contentPadding: EdgeInsets.only(left: 10.w, top: 15.h),
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
