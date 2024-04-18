import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';

class ProfileListTile extends StatelessWidget {
  String iconPic;
  String iconText;
  VoidCallback onTap;
  ProfileListTile(
      {super.key,
      required this.onTap,
      required this.iconPic,
      required this.iconText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        width: 330.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(width: 1.w, color: AppColors.primaryColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
            ),
            SvgPicture.asset(height: 25.h, iconPic),
            SizedBox(
              width: 20.w,
            ),
            Text(
              iconText,
              style: AllTextStyles.robotoMedium16(AppColors.blackColor),
            )
          ],
        ),
      ),
    );
  }
}
