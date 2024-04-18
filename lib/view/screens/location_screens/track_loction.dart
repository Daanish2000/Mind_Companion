import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';
import '../../../controllers/map_controller.dart';
import '../../../controllers/shared_prefrences/sharedprefs_controller.dart';
import '../../widgets/constants/app_toast/rating_toast.dart';
import 'location_access.dart';
import 'location_of_any_user.dart';

class TrackLocation extends StatefulWidget {
  const TrackLocation({super.key});
  @override
  State<TrackLocation> createState() => _TrackLocationState();
}

class _TrackLocationState extends State<TrackLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  MapGetXController mapGetXController = Get.put(MapGetXController());
  SharedPrefsController prefsController = Get.put(SharedPrefsController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          "Track Location",
          style: AllTextStyles.robotoMedium16(AppColors.blackColor)
              .copyWith(fontSize: 17.sp),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            5.h.sh,
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 4.0.w),
                child: GestureDetector(
                  onTap: () {
                    Get.to(const LocationAccess());
                  },
                  child: Text(
                    "Give Location Access",
                    style: AllTextStyles.robotoRegular10(AppColors.primaryColor)
                        .copyWith(fontSize: 13.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            5.h.sh,
            Container(
              height: 320.h,
              color: Colors.transparent,
              child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: mapGetXController.currentPosition.value!,
                    zoom: 10,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  zoomControlsEnabled: true,
                  markers: {
                    Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: mapGetXController.currentPosition.value!,
                      infoWindow: InfoWindow(
                          onTap: () {
                            Get.toNamed(trackLocation);
                          },
                          title: 'Current Location'),
                    ),
                  }),
            ),
            20.h.sh,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Saved Locations",
                    style: AllTextStyles.robotoMedium16(AppColors.lightGrey)
                        .copyWith(fontSize: 14),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(const LocationAccess());
                    },
                    child: Text(
                      "Edit",
                      style:
                          AllTextStyles.robotoMedium16(AppColors.primaryColor)
                              .copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            10.h.sh,
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user_locations')
                    .doc(prefsController.email.value)
                    .collection('permission')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error Occured}');
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.whiteColor,
                      backgroundColor: AppColors.primaryColor,
                    ));
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              height: 80.h,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColorLight,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Image.asset("assets/avator.png"),
                                    // 10.w.sw,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 90.w,
                                          //  color: Colors.red,
                                          child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            doc["name"].toString() ?? "",
                                            style:
                                                AllTextStyles.robotoSemiBold12(
                                                        AppColors.blackColor
                                                            .withOpacity(0.7))
                                                    .copyWith(fontSize: 16.sp),
                                          ),
                                        ),
                                        // 5.h.sh,
                                        // Text(
                                        //   "Location",
                                        //   style: AllTextStyles.robotoRegular10(
                                        //       AppColors.lightGrey),
                                        // ),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        var docId = doc['email'];
                                        log("Email=000 = ${docId}");

                                        await FirebaseFirestore.instance
                                            .collection('user_locations')
                                            .doc(prefsController.email.value)
                                            .collection('permission')
                                            .doc(docId)
                                            .delete()
                                            .whenComplete(() {
                                          setState(() {});
                                          log("Deleted Successfullyn= peter123@gmail.com");
                                          showAccountToast(
                                              context, "Remove Successfully");
                                        }).onError((error, stackTrace) {
                                          log("Error=0000000=${error.toString()}");
                                        });
                                        //  Get.toNamed(locationAccess);
                                      },
                                      child: Container(
                                        height: 30.h,
                                        width: 95.w,
                                        decoration: BoxDecoration(
                                            boxShadow: reuseAbleShadow,
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: Colors.white),
                                        child: Center(
                                          child: Text(
                                            "Remove Access",
                                            style:
                                                AllTextStyles.robotoRegular10(
                                                        AppColors.primaryColor)
                                                    .copyWith(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        mapGetXController
                                                .traceCurrentPosition.value =
                                            LatLng(doc['latitude'],
                                                doc['longitude']);
                                        Get.to(const LocationOfUser());
                                        // Get.toNamed(locationAccess);
                                      },
                                      child: Container(
                                        height: 40.h,
                                        width: 105.w,
                                        decoration: BoxDecoration(
                                            boxShadow: reuseAbleShadow,
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: Colors.white),
                                        child: Center(
                                          child: Text(
                                            "See Location",
                                            style:
                                                AllTextStyles.robotoRegular10(
                                                        AppColors.primaryColor)
                                                    .copyWith(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
