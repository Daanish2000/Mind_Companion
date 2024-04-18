import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_companion/view/widgets/constants/appcolors.dart';

class UnFillButton extends StatelessWidget {
  double height;
  double width;
  double borderRadius;
  VoidCallback onTap;
  TextStyle textStyle;

  String text;

  UnFillButton(
      {super.key,
      required this.width,
      required this.height,
      required this.onTap,
      required this.textStyle,
      required this.borderRadius,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(width: 1.5.w, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Center(
            child: Text(
          text,
          style: textStyle,
        )),
      ),
    );
  }
}
