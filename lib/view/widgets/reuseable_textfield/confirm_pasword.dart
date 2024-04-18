import 'dart:developer';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';

import '../../../controllers/signup_controller.dart';

class ConfirmPasswordTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color textColor;
  final TextStyle textStyle;
  final TextInputType keyboardType;
  final double width;
  final double height;

  SignUpController signUpController = Get.put(SignUpController());
  ConfirmPasswordTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.textColor,
    required this.textStyle,
    required this.height,
    // required this.formKey,
    this.keyboardType = TextInputType.text,
    this.width = double.infinity, // Default value is set to take full width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            log("Empty====");
            return 'Confirm Password is required';
          } else if (value.length < 6) {
            return 'Confirm Password must be at least 6 characters long';
          } else if (!value
              .contains(signUpController.password.text.trim().toString())) {
            return 'Password and Confirm Password Must Match';
          }

          return ""; // Validation passes
        },
        controller: controller,
        cursorColor: AppColors.primaryColor,
        keyboardType: keyboardType,
        obscureText: true,
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
          contentPadding: EdgeInsets.only(
            left: 10.w,
          ),
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
          errorMaxLines: 1,
        ),
      ),
    );
  }
}
