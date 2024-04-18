import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';

class SavedDialog extends StatelessWidget {
  final VoidCallback yes;

  const SavedDialog({
    Key? key,
    required this.yes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.symmetric(horizontal: 55.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          20.0.h.sh,
          Text("Saved",
              style: AllTextStyles.robotoSemiBold25(AppColors.primaryColor)),
          5.0.h.sh,
          Text(
            "Your task is Saved",
            style: AllTextStyles.robotoMedium14(AppColors.lightGrey),
          ),
          20.0.h.sh,
          FillButton(
            width: 100.w,
            height: 40.h,
            onTap: yes,
            textStyle: AllTextStyles.robotoMedium18(AppColors.whiteColor),
            borderRadius: 10.r,
            text: 'Ok',
          ),
          27.0.sh,
        ],
      ),
    );
  }
}
