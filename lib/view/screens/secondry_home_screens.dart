import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/map_controller.dart';
import '../../controllers/shared_prefrences/sharedprefs_controller.dart';
import '../widgets/reuseable_imports/resueable_imports.dart';
import '../widgets/reuseable_textfield/search_textfield.dart';

class SecondryHomeScreen extends StatefulWidget {
  const SecondryHomeScreen({super.key});

  @override
  State<SecondryHomeScreen> createState() => _SecondryHomeScreenState();
}

class _SecondryHomeScreenState extends State<SecondryHomeScreen> {
  HomeController homeController = Get.put(HomeController());

  final Completer<GoogleMapController> _controller = Completer();
  late StreamSubscription<Position> _positionStreamSubscription;

  MapGetXController mapGetXController = Get.put(MapGetXController());

  List<Marker> markers = <Marker>[];

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance; // Firebase Auth instance

  Future<void> _animateToMarker(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

  void updateFireStore(LatLng position, String name) async {
    User? user = auth.currentUser; // Get the current user
    if (user != null) {
      String userUid = user.uid;
      String userEmail = user.email ?? '';
      log("User Uid=${user.uid}");
      log("User Email=${user.email}");

      await fireStore.collection('user_locations').doc(user.email).set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'email': userEmail,
        "uid": userUid,
        'name': name,
      });
    }
  }

  SharedPrefsController sharedPrefsController =
      Get.put(SharedPrefsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (mapGetXController.userLocationAccessSP.isEmpty) {
        mapGetXController.getUserEmail();
      }
    });
    loadCurrentLocation();
    Future.delayed(const Duration(seconds: 0)).then((value) {
      mapGetXController.isShow.value = true;
    });
  }

  loadCurrentLocation() async {
    await getCurrentUser().then((value) async {
      try {
        _positionStreamSubscription = Geolocator.getPositionStream(
                locationSettings: AndroidSettings(
                    intervalDuration: const Duration(seconds: 12),
                    accuracy: LocationAccuracy.high))
            .listen((Position position) async {
          log("99999999999999999999===");
          mapGetXController.currentPosition.value =
              LatLng(position.latitude, position.longitude);

          await _animateToMarker(mapGetXController.currentPosition.value!);
          if (sharedPrefsController.name.value.isEmpty) {
            await homeController.getUserName().then((value) {
              updateFireStore(mapGetXController.currentPosition.value!,
                  sharedPrefsController.name.value);
              mapGetXController.storingLatLong();
            });
          } else {
            updateFireStore(mapGetXController.currentPosition.value!,
                sharedPrefsController.name.value);
            mapGetXController.storingLatLong();
          }
        });
      } catch (e) {
        log("Error==${e.toString()}");
      }
    });
  }

  Future<Position> getCurrentUser() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Permission Location Denied===$LocationPermission");

      await Geolocator.requestPermission()
          .then((value) {})
          .onError((error, stackTrace) async {
        await Geolocator.requestPermission();
        log("Error Occurred ==${error.toString()}");
      });
    } else {
      log("Permission Already Present");
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: AllTextStyles.robotoSemiBold24(AppColors.blackColor),
          ),
          Text(
            "ALLOW TECHNOLOGY TO EMPOWER YOUR MIND!",
            style: AllTextStyles.robotoRegular10(AppColors.lightGrey),
          ),
          20.h.sh,
          SearchTextField(
              hintText: "Search Task",
              controller: homeController.searchController,
              textColor: AppColors.lightGrey,
              textStyle: AllTextStyles.robotoMedium16(AppColors.lightGrey)),
          15.h.sh,
          Text(
            "Track Location",
            style: AllTextStyles.robotoMedium14(AppColors.blackColor),
          ),
          5.h.sh,
          Obx(
            () => Container(
              height: 100.h,
              color: Colors.white,
              child: Column(
                children: [
                  Visibility(
                    visible: mapGetXController.isShow.value,
                    child: Container(
                      height: 100.h,
                      color: Colors.white,
                      child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: mapGetXController.isShow.value
                                ? mapGetXController.currentPosition.value!
                                : const LatLng(37.4223, -122.0848),
                            zoom: 10,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          zoomControlsEnabled: true,
                          markers: {
                            Marker(
                              markerId: const MarkerId('currentLocation'),
                              position: mapGetXController.isShow.value
                                  ? mapGetXController.currentPosition.value!
                                  : const LatLng(37.4223, -122.0848),
                              onTap: () {
                                Get.toNamed(trackLocation);
                              },
                            ),
                          }),
                    ),
                  ),
                  Visibility(
                    visible: !mapGetXController.isShow.value,
                    child: Container(
                      height: 100.h,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          10.h.sh,
          Container(
            height: 334.h,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "To Do",
                    style: AllTextStyles.robotoMedium14(AppColors.blackColor),
                  ),
                  5.h.sh,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(yourTask);
                        },
                        child: Container(
                          height: 150.h,
                          width: 156.w,
                          decoration: BoxDecoration(
                              boxShadow: reuseAbleShadow,
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.primaryColorLight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(height: 90.h, "assets/todo.svg"),
                              15.0.h.sh,
                              Text(
                                "Your Tasks",
                                style: AllTextStyles.robotoMediumBold18(
                                        AppColors.blackColor)
                                    .copyWith(fontSize: 14.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                      10.0.w.sw,
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(toDaysTask);
                        },
                        child: Container(
                          height: 150.h,
                          width: 156.w,
                          decoration: BoxDecoration(
                              boxShadow: reuseAbleShadow,
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.repeatedTask),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  height: 90.h, "assets/repeate task.svg"),
                              15.0.h.sh,
                              Text(
                                "Repeated Task",
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
                  20.h.sh,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "To Day Task",
                        style:
                            AllTextStyles.robotoMedium14(AppColors.blackColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(yourTask);
                        },
                        child: Text(
                          "See all",
                          style: AllTextStyles.robotoMedium14(
                              AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  5.h.sh,
                  Container(
                    height: 150.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFDCB2),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0.w, top: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Complete Your",
                                style: AllTextStyles.robotoRegular14(
                                        AppColors.blackColor)
                                    .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                "To day Tasks",
                                style: AllTextStyles.robotoRegular14(
                                        AppColors.blackColor)
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                textAlign: TextAlign.start,
                              ),
                              25.h.sh,
                              Text(
                                "To haven't complete",
                                style: AllTextStyles.robotoRegular14(
                                        AppColors.blackColor)
                                    .copyWith(fontSize: 13.sp),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                "your tasks",
                                style: AllTextStyles.robotoRegular14(
                                        AppColors.blackColor)
                                    .copyWith(fontSize: 13.sp),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: SvgPicture.asset("assets/to_day_task.svg"),
                          )
                        ],
                      ),
                    ),
                  ),
                  10.h.sh,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
