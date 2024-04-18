import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppColors {
  static const primaryColor = Color(0xff30B9C2);

  static const primaryColorLight = Color(0xffBDE9EC);
  static const searchbarColor = Color(0xffB7B7B7);
  static const blackColor = Color(0xff212121);
  static const whiteColor = Color(0xffFFFFFF);
  static const lightGrey = Color(0xff6B6B6B);
  static const textLightGrey = Color(0xff727272);
  static const lightSecondary = Color(0xffEDD0FF);
  static const toDoTask = Color(0xffEDAB7C);
  static const inProgressTask = Color(0xffED98B5);
  static const completedTask = Color(0xff97E3DB);
  static const repeatTask = Color(0xffBAE0FF);
  static const repeatedTask = Color(0xffEDD0FF);
  static const audioReminder = Color(0xff3073C2);
  static const notificationReminder = Color(0xffCF82FF);
  static const starsColors = Color(0xffF9E106);
  static const doneColor = Color(0xff97E3DB);
  static const deleteColor = Color(0xffF9C3BF);
  static const listCircle1 = Color(0xffF6CDDB);
  static const listCircle1Border = Color(0xffEFABC3);
  static const listCircle2 = Color(0xffE7D0EB);
  static const listCircle2Border = Color(0xffD89EE3);
  static const listCircle3 = Color(0xffFBEFC9);
  static const listCircle3Border = Color(0xffEAD490);
  static const listCircle4 = Color(0xffC8E6E3);
  static const listCircle4Border = Color(0xff74BBB3);
  static const listCircle5 = Color(0xffD7EBD8);
  static const listCircle5Border = Color(0xffAAD4AC);
  static const listCircle6 = Color(0xffCFE6F9);
  static const listCircle6Border = Color(0xff9BBDD8);
  static const listCircle7 = Color(0xffDCE1E4);
  static const listCircle7Border = Color(0xff9AB6C6);

  static openUrl(String anyUrl) async {
    final Uri _url = Uri.parse(anyUrl);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
