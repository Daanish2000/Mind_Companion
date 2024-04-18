import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension SizeBoxUsed on double {
  //For SizeBox :
  SizedBox get sh => SizedBox(
        height: this,
      );
  SizedBox get sw => SizedBox(
        width: this,
      );
}

//For Formatting DateTime :
extension CustomDate on DateTime {
  String customDate() {
    return DateFormat.yMMMMEEEEd().format(this);
  }

  String formattedDate() {
    return DateFormat.yMd().format(this); // Change the format as needed
  }

  String formattedDateAndTime() {
    // Format date using DateFormat.yMd for "YYYY-MM-DD" or adjust as needed
    String formattedDate = DateFormat.yMd().format(this);

    // Format time using DateFormat.Hm for "HH:mm" (24-hour format) or adjust as needed
    String formattedTime = DateFormat.Hm().format(this);

    // Combine formatted date and time with a space and add PM/AM indicator (optional)
    return "$formattedDate $formattedTime${this.hour >= 12 ? 'Pm' : 'Am'}";
  }
}
