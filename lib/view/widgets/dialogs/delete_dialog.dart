import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';

import '../constants/reuseable_boxshadow.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback yes;
  final VoidCallback no;

  const DeleteDialog({
    Key? key,
    required this.yes,
    required this.no,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          25.0.h.sh,
          Text("Are You Sure",
              style: AllTextStyles.robotoSemiBold25(AppColors.primaryColor)
                  .copyWith(fontSize: 20.sp)),
          Text(
            "You want to Delete",
            style: AllTextStyles.robotoMedium14(AppColors.lightGrey),
          ),
          35.0.h.sh,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UnFillButton(
                    width: 75,
                    height: 38.h,
                    onTap: yes,
                    textStyle:
                        AllTextStyles.robotoMediumBold18(AppColors.primaryColor)
                            .copyWith(fontSize: 16.sp),
                    borderRadius: 10.r,
                    text: "Yes"),
                15.0.w.sw,
                FillButton(
                  width: 75.w,
                  height: 38.h,
                  onTap: no,
                  textStyle: AllTextStyles.robotoMedium18(AppColors.whiteColor)
                      .copyWith(fontSize: 16.sp),
                  borderRadius: 10.r,
                  text: 'No',
                ),
              ],
            ),
          ),
          40.0.sh,
        ],
      ),
    );
  }
}
