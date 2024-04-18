import 'dart:developer';
import 'dart:ffi';

import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';

import '../../../controllers/shared_prefrences/sharedprefs_controller.dart';
import '../../../controllers/signup_controller.dart';

class LetsGoSplash extends StatefulWidget {
  const LetsGoSplash({super.key});

  @override
  State<LetsGoSplash> createState() => _LetsGoSplashState();
}

class _LetsGoSplashState extends State<LetsGoSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SignUpController signUpController = Get.put(SignUpController());
  SharedPrefsController sharedPrefsController =
      Get.put(SharedPrefsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          130.h.sh,
          Center(child: SvgPicture.asset(height: 190.h, "assets/splash.svg")),
          20.h.sh,
          Center(
            child: Text(
              "Mind Companion",
              style: AllTextStyles.robotoSemiBold18(AppColors.primaryColor),
            ),
          ),
          const Spacer(),
          Center(
              child: Image.asset(
                  height: 100.h, width: 200.w, "assets/splash_subimg.png")),
          15.h.sh,
          FillButton(
              width: 140.w,
              height: 48.h,
              onTap: () {
                log("Shared Preferences= = ${sharedPrefsController.isLoginIn.value}");
                sharedPrefsController.isLoginIn.value
                    ? Get.offNamed(homeScreen)
                    : Get.offNamed(signUp);
              },
              textStyle: AllTextStyles.robotoSemiBold18(AppColors.whiteColor)
                  .copyWith(fontSize: 16.sp),
              borderRadius: 10.r,
              text: "Let's Go"),
          40.h.sh,
        ],
      ),
    );
  }
}
