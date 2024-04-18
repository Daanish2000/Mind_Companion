import 'dart:developer';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mind_companion/view/widgets/notifications/notification.dart';
import 'package:mind_companion/view/widgets/routes/myroutes.dart';
import 'package:mind_companion/view/widgets/routes/routes_names.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/db_controller/dbHelper.dart';
import 'controllers/shared_prefrences/sharedpreferences.dart';
import 'controllers/shared_prefrences/sharedprefs_controller.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefs.init();
  tz.initializeTimeZones();

  DBHelper().initDatabase();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    //DevicePreview(builder: (BuildContext context) {
    //  return
    MyApp(),
  );
}
//  )
//)
//;
//}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPrefsController sharedPrefsController =
      Get.put(SharedPrefsController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPrefsController.isLoginIn.value =
          sharedPreferences.getBool("isLogIn") ?? false;
      log("...Login In User ===${sharedPrefsController.isLoginIn.value}");
      NotificationServices().initializedNotifications();
    });

    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 752),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: MyRoutes.generateRoute,
            initialRoute: mainSplash,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            title: 'Mind Companion',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // home: const AppPrivacyPolicy(),
          );
        });
  }
}
