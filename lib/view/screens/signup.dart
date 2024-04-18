import 'dart:developer';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';
import '../../controllers/signup_controller.dart';
import '../widgets/constants/app_toast/rating_toast.dart';
import '../widgets/reuseable_textfield/confirm_pasword.dart';
import '../widgets/reuseable_textfield/reuseable_email_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void dispose() {
    signUpController.clearingTextField();
    // TODO: implement dispose
    super.dispose();
  }

  SignUpController signUpController = Get.put(SignUpController());
  final GlobalKey<FormState> password = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Form(
            key: password,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                45.h.sh,
                Center(
                    child: Image.asset(
                        width: 320.w,
                        height: 100.h,
                        "assets/splash_subimg.png")),
                10.h.sh,
                Text(
                  "Create an Account",
                  style: AllTextStyles.robotoSemiBold20(AppColors.primaryColor),
                ),
                2.h.sh,
                Text(
                  "ALLOW TECHNOLOGY TO EMPOWER YOUR MIND!",
                  style: AllTextStyles.robotoRegular10(AppColors.lightGrey),
                ),
                30.h.sh,
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Name",
                          style:
                              AllTextStyles.robotoRegular10(AppColors.lightGrey)
                                  .copyWith(fontSize: 12.sp),
                        ),
                        5.h.sh,
                        Container(
                          height: 65.h,
                          child: NormalTextField(
                              width: 153.w,
                              height: 65.h,
                              hintText: "Peter",
                              controller: signUpController.firstName,
                              textColor: AppColors.primaryColor,
                              textStyle: AllTextStyles.robotoRegular14(
                                  AppColors.lightGrey)),
                        )
                      ],
                    ),
                    10.h.sw,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last Name",
                          style:
                              AllTextStyles.robotoRegular10(AppColors.lightGrey)
                                  .copyWith(fontSize: 12.sp),
                        ),
                        5.h.sh,
                        Container(
                          height: 65.h,
                          child: NormalTextField(
                              width: 152.w,
                              height: 65.h,
                              hintText: "john",
                              controller: signUpController.lastName,
                              textColor: AppColors.primaryColor,
                              textStyle: AllTextStyles.robotoRegular14(
                                  AppColors.lightGrey)),
                        ),
                      ],
                    ),
                  ],
                ),
                // 15.h.sh,
                Text(
                  "Email",
                  style: AllTextStyles.robotoRegular10(AppColors.lightGrey)
                      .copyWith(fontSize: 12.sp),
                ),
                5.h.sh,
                Container(
                  height: 65.h,
                  child: EmailTextField(
                    height: 65.h,
                    width: 318.w,
                    hintText: "abc123@gmail.com",
                    controller: signUpController.email,
                    textColor: AppColors.primaryColor,
                    keyboardType: TextInputType.emailAddress,
                    textStyle:
                        AllTextStyles.robotoRegular14(AppColors.lightGrey),
                  ),
                ),
                // 15.h.sh,
                Text(
                  "Password",
                  style: AllTextStyles.robotoRegular10(AppColors.lightGrey)
                      .copyWith(fontSize: 12.sp),
                ),
                5.h.sh,
                Container(
                  height: 65.h,
                  child: PasswordTextField(
                    width: 318.w,
                    height: 65.h,
                    hintText: "********",
                    controller: signUpController.password,
                    textColor: AppColors.primaryColor,
                    keyboardType: TextInputType.visiblePassword,
                    textStyle:
                        AllTextStyles.robotoRegular14(AppColors.lightGrey),
                  ),
                ),
                // 15.h.sh,
                Text(
                  "Confirm Password",
                  style: AllTextStyles.robotoRegular10(AppColors.lightGrey)
                      .copyWith(fontSize: 12.sp),
                ),
                5.h.sh,
                Container(
                  height: 65.h,
                  child: ConfirmPasswordTextField(
                    width: 318.w,
                    height: 45.h,
                    hintText: "********",
                    controller: signUpController.confirmPassword,
                    textColor: AppColors.primaryColor,
                    keyboardType: TextInputType.visiblePassword,
                    textStyle:
                        AllTextStyles.robotoRegular14(AppColors.lightGrey),
                  ),
                ),
                40.h.sh,
                Center(
                  child: FillButton(
                      width: 150.w,
                      height: 45.h,
                      onTap: () {
                        if (password.currentState!.validate()) {
                        } else {
                          if (signUpController.firstName.text
                                  .trim()
                                  .toString()
                                  .isEmpty ||
                              signUpController.lastName.text
                                  .trim()
                                  .toString()
                                  .isEmpty) {
                          } else {
                            if (signUpController.password.text
                                    .trim()
                                    .toString() ==
                                signUpController.confirmPassword.text
                                    .trim()
                                    .toString()) {
                              if (signUpController.email.text
                                  .trim()
                                  .toString()
                                  .contains(".com")) {
                                log(" ====== Contains .com    =============");
                                signUpController.signUp(
                                    signUpController.firstName.text
                                        .trim()
                                        .toString(),
                                    signUpController.lastName.text
                                        .trim()
                                        .toString(),
                                    signUpController.email.text
                                        .trim()
                                        .toString(),
                                    signUpController.password.text
                                        .trim()
                                        .toString(),
                                    context);
                              } else {
                                badEmailToast(context, "Email Error");
                              }
                            } else {
                              passwordToast(context,
                                  "password and confirm password must match");
                            }
                          }
                        }
                      },
                      textStyle:
                          AllTextStyles.robotoSemiBold18(AppColors.whiteColor),
                      borderRadius: 8.r,
                      text: "Sign Up"),
                ),
                12.h.sh,
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Already Have an account?",
                          style: AllTextStyles.robotoSemiBold10(
                                  AppColors.blackColor)
                              .copyWith(fontSize: 12.sp),
                        ),
                      ),
                      2.h.sw,
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.offNamed(login);
                          },
                          child: Text(
                            "Sign In",
                            style: AllTextStyles.robotoSemiBold10(
                                    AppColors.primaryColor)
                                .copyWith(fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                16.h.sh,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        SignUpController.openUrl("https://www.facebook.com");
                      },
                      child: Image.asset(
                        width: 36.w,
                        height: 36.h,
                        "assets/fb.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    10.h.sw,
                    GestureDetector(
                      onTap: () {
                        SignUpController.openUrl("https://www.google.com");
                      },
                      child: Image.asset(
                          fit: BoxFit.cover,
                          width: 32.w,
                          height: 32.h,
                          "assets/google.png"),
                    ),
                    10.h.sw,
                    GestureDetector(
                      onTap: () {
                        SignUpController.openUrl("https://www.instagram.com");
                      },
                      child: Image.asset(
                          fit: BoxFit.cover,
                          width: 32.w,
                          height: 32.h,
                          "assets/insta.png"),
                    ),
                  ],
                ),
                0.h.sh,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
