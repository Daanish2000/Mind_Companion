import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mind_companion/view/screens/home_screens.dart';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';
import 'package:mind_companion/view/widgets/routes/routes_names.dart';
import '../../screens/location_screens/location_access.dart';
import '../../screens/location_screens/track_loction.dart';
import '../../screens/login.dart';
import '../../screens/profile_screen.dart';
import '../../screens/signup.dart';
import '../../screens/splash_screens/lets_go_splash.dart';
import '../../screens/splash_screens/main_splash.dart';
import '../../screens/task_screens/add_new_task.dart';
import '../../screens/task_screens/edit_repeatedtasks.dart';
import '../../screens/task_screens/edit_task.dart';
import '../../screens/task_screens/repeat_task.dart';
import '../../screens/task_screens/today_task_screen.dart';
import '../../screens/task_screens/your_task_screen.dart';

class MyRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainSplash:
        return MaterialPageRoute(builder: (context) => const MainSplash());
      case letsGoSplash:
        return MaterialPageRoute(builder: (context) => const LetsGoSplash());
      case homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case signUp:
        return MaterialPageRoute(builder: (context) => const SignUp());
      case login:
        return MaterialPageRoute(builder: (context) => const Login());
      case profile:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case yourTask:
        return MaterialPageRoute(builder: (context) => const YourTaskScreen());
      case addNewTask:
        return MaterialPageRoute(builder: (context) => const AddNewTask());
      case toDaysTask:
        return MaterialPageRoute(builder: (context) => TodayTaskScreen());
      case trackLocation:
        return MaterialPageRoute(builder: (context) => const TrackLocation());
      case locationAccess:
        return MaterialPageRoute(builder: (context) => const LocationAccess());
      case repeatTask:
        return MaterialPageRoute(builder: (context) => const RepeatTask());
      case editTask:
        return MaterialPageRoute(builder: (context) => EditTask());
      case editRepeatedTask:
        var data = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (context) => EditRepeatedTask(
                  isFromYoursScreen: data,
                ));

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Text("no route Found"),
                ));
    }
  }
}
