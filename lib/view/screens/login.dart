import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/signup_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = Get.put(LoginController());
  SignUpController signUpController = Get.put(SignUpController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    loginController.clearingLoginTextField();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        50.h.sh,
                        Center(
                            child: Image.asset(
                                width: 320.w,
                                height: 100.h,
                                "assets/splash_subimg.png")),
                        10.h.sh,
                        Text(
                          "Sign In",
                          style: AllTextStyles.robotoSemiBold20(
                              AppColors.primaryColor),
                        ),
                        2.h.sh,
                        Text(
                          "ALLOW TECHNOLOGY TO EMPOWER YOUR MIND!",
                          style: AllTextStyles.robotoRegular10(
                              AppColors.lightGrey),
                        ),
                        30.h.sh,
                        Text(
                          "Email",
                          style:
                              AllTextStyles.robotoRegular10(AppColors.lightGrey)
                                  .copyWith(fontSize: 12.sp),
                        ),
                        5.h.sh,
                        Container(
                          height: 70.h,
                          child: NormalTextField(
                              width: 318.w,
                              height: 65.h,
                              hintText: "abc123@gmail.com",
                              controller: loginController.loginEmail,
                              textColor: AppColors.primaryColor,
                              keyboardType: TextInputType.emailAddress,
                              textStyle: AllTextStyles.robotoRegular14(
                                  AppColors.lightGrey)),
                        ),
                        15.h.sh,
                        Text(
                          "Password",
                          style:
                              AllTextStyles.robotoRegular10(AppColors.lightGrey)
                                  .copyWith(fontSize: 12.sp),
                        ),
                        5.h.sh,
                        Container(
                          height: 70.h,
                          child: PasswordTextField(
                            width: 318.w,
                            hintText: "********",
                            controller: loginController.loginPassword,
                            textColor: AppColors.primaryColor,
                            keyboardType: TextInputType.visiblePassword,
                            textStyle: AllTextStyles.robotoRegular14(
                                AppColors.lightGrey),
                            height: 65.h,
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: TextButton(
                        //       onPressed: () {
                        //         // signUpController.loginUser(
                        //         //     loginController.loginEmail.text
                        //         //         .trim()
                        //         //         .toString(),
                        //         //     loginController.loginPassword.text
                        //         //         .trim()
                        //         //         .toString(),
                        //         //     context);
                        //       },
                        //       child: Text(
                        //         "Forget Password",
                        //         style: AllTextStyles.robotoSemiBold12(
                        //             AppColors.primaryColor),
                        //       )),
                        // ),
                      ],
                    ),

                    // Spacer(),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                          child: FillButton(
                              width: 150.w,
                              height: 45.h,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                } else {
                                  signUpController.loginUser(
                                      loginController.loginEmail.text
                                          .trim()
                                          .toString(),
                                      loginController.loginPassword.text
                                          .trim()
                                          .toString(),
                                      context);
                                }
                              },
                              textStyle: AllTextStyles.robotoSemiBold18(
                                  AppColors.whiteColor),
                              borderRadius: 8.r,
                              text: "Sign In"),
                        ),
                        12.h.sh,
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Create an account?",
                                  style: AllTextStyles.robotoSemiBold10(
                                          AppColors.blackColor)
                                      .copyWith(fontSize: 12.sp),
                                ),
                              ),
                              2.h.sw,
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.offNamed(signUp);
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: AllTextStyles.robotoSemiBold10(
                                            AppColors.primaryColor)
                                        .copyWith(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        30.h.sh,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                SignUpController.openUrl(
                                    "https://www.facebook.com");
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
                                SignUpController.openUrl(
                                    "https://www.google.com");
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
                                SignUpController.openUrl(
                                    "https://www.instagram.com");
                              },
                              child: Image.asset(
                                  fit: BoxFit.cover,
                                  width: 32.w,
                                  height: 32.h,
                                  "assets/insta.png"),
                            ),
                          ],
                        ),
                        10.h.sh,
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
