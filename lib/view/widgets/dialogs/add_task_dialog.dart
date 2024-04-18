import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';
import '../constants/reuseable_boxshadow.dart';

class AddTaskDialog extends StatelessWidget {
  final String newTask;
  final String repeatTask;
  final VoidCallback addTask;
  final VoidCallback repeatedTask;

  const AddTaskDialog({
    Key? key,
    required this.newTask,
    required this.repeatTask,
    required this.addTask,
    required this.repeatedTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      surfaceTintColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 35.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          25.0.h.sh,
          Text("Add Task",
              style: AllTextStyles.robotoMediumBold18(AppColors.blackColor)),
          25.0.h.sh,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: addTask,
                  child: Container(
                    height: 140.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                        boxShadow: reuseAbleShadow,
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.primaryColorLight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/todo.svg"),
                        15.0.h.sh,
                        Text(
                          newTask,
                          style: AllTextStyles.robotoMediumBold18(
                                  AppColors.blackColor)
                              .copyWith(fontSize: 14.sp),
                        )
                      ],
                    ),
                  ),
                ),
                15.0.w.sw,
                GestureDetector(
                  onTap: repeatedTask,
                  child: Container(
                    height: 140.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                        boxShadow: reuseAbleShadow,
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.repeatedTask),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/repeate task.svg"),
                        15.0.h.sh,
                        Text(
                          repeatTask,
                          style: AllTextStyles.robotoMediumBold18(
                                  AppColors.blackColor)
                              .copyWith(fontSize: 14.sp),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          50.0.sh,
        ],
      ),
    );
  }
}
