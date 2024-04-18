import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///Adding New Task Model
class AddTaskDBModel {
  int? taskId;
  String? taskTitle;
  String? taskDescription;

  String? taskDate;

  String? taskTime;

  Color? taskColor;

  bool? isAudio;
  bool? isCompleted;
  bool? isInProgress;
  bool? isInToDo;
  bool? isRepeated;
  String? repeatPattern;
  bool? isTimePassed;

  AddTaskDBModel({
    this.taskId,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDate,
    required this.taskTime,
    required this.taskColor,
    required this.isAudio,
    required this.isCompleted,
    required this.isInProgress,
    required this.isInToDo,
    required this.isRepeated,
    required this.repeatPattern,
    this.isTimePassed,
  });

  //=== For Sending Data in LocalDatabase
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['taskId'] = taskId;
    map['taskTitle'] = taskTitle;
    map['taskDescription'] = taskDescription;
    map['taskDate'] = taskDate;
    map['taskTime'] = taskTime;
    map['taskColor'] = taskColor?.value;
    map['isAudio'] = isAudio! ? 1 : 0;
    map['isCompleted'] = isCompleted! ? 1 : 0;
    map['isInProgress'] = isInProgress! ? 1 : 0;
    map['isInToDo'] = isInToDo! ? 1 : 0;
    map['isRepeated'] = isRepeated! ? 1 : 0;
    map['repeatPattern'] = repeatPattern;
    return map;
  }

  //===For Fetch Data From Database ===//
  factory AddTaskDBModel.fromMapObject(Map<String, dynamic> map) {
    log("Task Date9090= ${map['taskDate']}");
    bool isTimePasses = isTaskDateTimePassed(map['taskDate'], map['taskTime']);
    log("IsPassed==$isTimePasses");
    log('Map object: $map');
    return AddTaskDBModel(
      taskId: map['taskId'],
      taskTitle: map['taskTitle'],
      taskDescription: map['taskDescription'],
      taskDate: map['taskDate'],
      taskTime: map['taskTime'],
      taskColor: Color(map['taskColor']),
      isAudio: map['isAudio'] == 1 ? true : false,
      isCompleted: map['isCompleted'] == 1 ? true : false,
      isInProgress: map['isInProgress'] == 1 ? true : false,
      isInToDo: map['isInToDo'] == 1 ? true : false,
      isRepeated: map['isRepeated'] == 1 ? true : false,
      repeatPattern: map['repeatPattern'],
      isTimePassed: isTimePasses,
    );
  }

//For Making InProgress By Matching Time:
  static bool isTaskDateTimePassed(String taskDateStr, String taskTimeStr) {
    String formattedDateTimeString = '$taskDateStr $taskTimeStr';

    DateTime dateTime =
        DateFormat('M/d/yyyy hh:mma').parse(formattedDateTimeString);
    DateTime currentDateTime = DateTime.now();
    return currentDateTime.isAfter(dateTime);
  }
}
