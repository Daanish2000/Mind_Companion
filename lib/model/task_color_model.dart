import '../view/widgets/reuseable_imports/resueable_imports.dart';

///Color Selection Model
class TaskColorModel {
  Color circleColor;
  Color circleBorderColor;
  bool isSelected;
  TaskColorModel(
      {required this.circleColor,
      required this.circleBorderColor,
      required this.isSelected});
}
