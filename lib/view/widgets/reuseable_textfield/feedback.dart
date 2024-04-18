import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';
import 'package:mind_companion/view/widgets/reuseable_textfield/reuseable_email_textfield.dart';
import '../../../controllers/feedback_controller.dart';
import '../constants/app_toast/rating_toast.dart';
import 'description_reuseable_textfield.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final GlobalKey<FormState> password = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  FeedBackController feedBackController = Get.put(FeedBackController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        child: Container(
          height: 400.h,
          //color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.h.sh,
              Center(
                  child: Text(
                "FeedBack",
                style:
                    TextStyle(fontSize: 20.sp, color: AppColors.primaryColor),
              )),
              20.h.sh,

              Text(
                "Title",
                style: AllTextStyles.robotoRegular10(AppColors.lightGrey)
                    .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
              5.h.sh,
              Container(
                height: 65.h,
                child: NormalTextField(
                    width: double.maxFinite,
                    height: 65.h,
                    hintText: "Peter",
                    controller: feedBackController.subject,
                    textColor: AppColors.primaryColor,
                    textStyle:
                        AllTextStyles.robotoRegular14(AppColors.lightGrey)),
              ),
              // 15.h.sh,

              // 15.h.sh,
              Text(
                "Description",
                style: AllTextStyles.robotoRegular10(AppColors.lightGrey)
                    .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
              5.h.sh,
              Container(
                height: 125.h,
                child: DescriptionTextField(
                    width: double.maxFinite,
                    hintText: "Description",
                    controller: feedBackController.description,
                    textColor: AppColors.primaryColor,
                    textStyle:
                        AllTextStyles.robotoRegular14(AppColors.lightGrey)),
              ),
              // 15.h.sh,
              30.h.sh,
              Center(
                child: FillButton(
                    width: 135.w,
                    height: 45.h,
                    onTap: () {
                      if (feedBackController.subject.text.isEmpty ||
                          feedBackController.description.text.isEmpty) {
                        showRatingToast(
                            context, "Title or Description is Empty");
                      } else {
                        Navigator.pop(context);
                        feedBackController.openEmail().then((value) {});
                      }
                    },
                    textStyle:
                        AllTextStyles.robotoMedium16(AppColors.whiteColor),
                    borderRadius: 10.r,
                    text: "Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
