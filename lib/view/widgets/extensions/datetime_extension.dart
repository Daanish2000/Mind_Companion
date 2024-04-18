import 'package:intl/intl.dart';

extension CustomTimess on DateTime {
  String formattedTimes() {
    return DateFormat('hh:mm a').format(this); // Customize format as needed
  } // Change the format as needed
}
