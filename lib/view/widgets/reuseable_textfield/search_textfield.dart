import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/appcolors.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color textColor;
  final TextStyle textStyle;
  final TextInputType keyboardType;
  final double width;
  SearchTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.textColor,
    required this.textStyle,
    this.keyboardType = TextInputType.text,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.h,
        width: 360.w,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.3, 0.3),
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-0.3, -0.3),
              )
            ],
            borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: TextField(
            cursorColor: AppColors.primaryColor,

            decoration: InputDecoration(
              hintText: hintText,
              filled: true,

              fillColor: AppColors.searchbarColor.withOpacity(0.16),
              // Background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0.r), // Rounded border
                borderSide: BorderSide.none, // No border
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
              // Padding inside the TextField

              suffixIcon: Padding(
                  padding: EdgeInsets.all(12.0.w),
                  child: SvgPicture.asset("assets/search.svg")),
            ),
            style: TextStyle(color: textColor), // Text color
          ),
        ));
  }
}
