import 'dart:developer';
import 'package:intl/intl.dart';
import '../model/task_color_model.dart';
import '../view/widgets/reuseable_imports/resueable_imports.dart';

class EditTaskController extends GetxController {
  TextEditingController editTaskTitle = TextEditingController();

  TextEditingController editTaskDescription = TextEditingController();
  RxList<TaskColorModel> editTaskColor = <TaskColorModel>[
    TaskColorModel(
        circleColor: const Color(0xffF6CDDB),
        circleBorderColor: const Color(0xffEFABC3),
        isSelected: true),
    TaskColorModel(
        circleColor: const Color(0xffE7D0EB),
        circleBorderColor: const Color(0xffD89EE3),
        isSelected: false),
    TaskColorModel(
        circleColor: const Color(0xffFBEFC9),
        circleBorderColor: const Color(0xffEAD490),
        isSelected: false),
    TaskColorModel(
        circleColor: const Color(0xffC8E6E3),
        circleBorderColor: const Color(0xff74BBB3),
        isSelected: false),
    TaskColorModel(
        circleColor: const Color(0xffD7EBD8),
        circleBorderColor: const Color(0xffAAD4AC),
        isSelected: false),
    TaskColorModel(
        circleColor: const Color(0xffCFE6F9),
        circleBorderColor: const Color(0xff9BBDD8),
        isSelected: false),
    TaskColorModel(
        circleColor: const Color(0xffDCE1E4),
        circleBorderColor: const Color(0xff9AB6C6),
        isSelected: false),
  ].obs;
  RxBool isAudio = false.obs;
  RxBool isCompleted = false.obs;
  RxBool isToDo = false.obs;
  RxBool isInProgress = false.obs;
  RxBool isRepeated = false.obs;
  RxString editRepeatPattern = "".obs;
  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formatter = DateFormat('hh:mma');
    return formatter.format(dt);
  }

  Rx<int> taskId = 0.obs;

  clearingEditTaskTextField() {
    editTaskTitle.clear();
    editTaskDescription.clear();
    selectedDate.value = "";
    selectedTime.value = "";
    taskId.value = 0;
    isInProgress.value = false;
    isToDo.value = false;
    isCompleted.value = false;
  }

  //Date Picker:
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                AppColors.primaryColor, // Change the background color here
            // Change the color of the selected time
            colorScheme:
                const ColorScheme.light(primary: AppColors.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      selectedDate.value = picked.formattedDate();

      log("Selected Date ===$selectedDate");
    }
  }

// Add this variable in your state class to store the selected date

  Rx<String> selectedDate = "".obs;
  Rx<String> selectedTime = "".obs;

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                AppColors.primaryColor, // Change the background color here
            // Change the color of the selected time
            colorScheme:
                const ColorScheme.light(primary: AppColors.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      selectedTime.value = formatTimeOfDay(picked);
    }
  }
}
