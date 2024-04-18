import 'package:mind_companion/view/screens/privacy_policy.dart';

import '../../controllers/feedback_controller.dart';
import '../../controllers/shared_prefrences/sharedprefs_controller.dart';
import '../../controllers/signup_controller.dart';
import '../widgets/dialogs/original_rating.dart';

import '../widgets/reuseable_imports/resueable_imports.dart';
import '../widgets/reuseable_textfield/feedback.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SignUpController signUpController = Get.put(SignUpController());
  SharedPrefsController sharedPrefsController =
      Get.put(SharedPrefsController());
  FeedBackController feedBackController = Get.put(FeedBackController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 12.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            20.h.sh,
            Row(
              children: [
                Image.asset(
                    height: 70.h, width: 70.w, "assets/profile_img.png"),
                8.w.sw,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        sharedPrefsController.name.value,
                        style:
                            AllTextStyles.robotoMedium14(AppColors.blackColor)
                                .copyWith(fontSize: 18.sp),
                      ),
                    ),
                    2.h.sh,
                    // Text(
                    //   "New York",
                    //   style: AllTextStyles.robotoSemiBold10(AppColors.lightGrey)
                    //       .copyWith(fontSize: 12),
                    // ),
                  ],
                )
              ],
            ),
            50.h.sh,
            ProfileListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddTaskDialog(
                        newTask: 'New Task',
                        repeatTask: 'Repeat Task',
                        addTask: () {
                          Get.back();
                          Get.toNamed(addNewTask);
                        },
                        repeatedTask: () {
                          Get.back();

                          Get.toNamed(repeatTask);
                        },
                      );
                    });
              },
              iconPic: 'assets/profile/create_task.svg',
              iconText: 'Create Task',
            ),
            20.h.sh,
            ProfileListTile(
              onTap: () {
                Get.back();
                Get.to(const AppPrivacyPolicy());
                // AppColors.openUrl(
                //     "https://www.termsfeed.com/blog/sample-privacy-policy-template/");
              },
              iconPic: 'assets/profile/privacy_policy.svg',
              iconText: 'Privacy Policy',
            ),
            20.h.sh,
            ProfileListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const OriginalRatingDialog();
                    });
              },
              iconPic: 'assets/profile/rate_us.svg',
              iconText: 'Rate Us',
            ),
            20.h.sh,
            ProfileListTile(
              onTap: () {
                feedBackController.subject.clear();
                feedBackController.description.clear();
                showDialog(
                    context: context,
                    builder: (context) {
                      return FeedBack();
                    });
                // AppColors.openEmail();
              },
              iconPic: 'assets/profile/feed_back.svg',
              iconText: 'Feedback',
            ),
            20.h.sh,
            ProfileListTile(
              onTap: () {
                signUpController.signOutUser();
              },
              iconPic: 'assets/profile/logout.svg',
              iconText: 'Log Out',
            ),
          ],
        ),
      ),
    );
  }
}
