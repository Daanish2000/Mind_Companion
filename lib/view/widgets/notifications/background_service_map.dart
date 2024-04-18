// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:ui';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
// import 'package:path/path.dart' as path;
// import 'package:flutter/widgets.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
//
// import '../../../controllers/map_controller.dart';
// import '../../../firebase_options.dart';
//
// List<String> previousStatuses = [];
// MapGetXController mapGetXController = Get.put(MapGetXController());
// Future<void> initailizedService() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   final service = FlutterBackgroundService();
//   await service.configure(
//       iosConfiguration: IosConfiguration(
//         autoStart: false,
//         onBackground: onIosBackground,
//         onForeground: onStart,
//       ),
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         isForegroundMode: true,
//         autoStart: true,
//         initialNotificationContent: "Mind Companion",
//         initialNotificationTitle: "Mind Companion",
//         autoStartOnBoot: false,
//       ));
// }
//
// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//
//   return true;
// }
//
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) {
//   DartPluginRegistrant.ensureInitialized();
//
//   if (service is AndroidServiceInstance) {
//     service.on("setAsBackground").listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//   service.on("stopService").listen((event) {
//     service.stopSelf();
//   });
//   Timer.periodic(const Duration(seconds: 5), (timer) async {
//     await Firebase.initializeApp();
//     mapGetXController.startLocationTracking();
//     service.invoke('update');
//   });
// }
//
// Future stopService() async {
//   final service = FlutterBackgroundService();
//   bool isRunning = await service.isRunning();
//   if (isRunning) {
//     log("Backround Work Stopped For Whatsapp ");
//     service.invoke("stopService");
//   }
// }
