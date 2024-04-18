// import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';
// import 'package:share_plus/share_plus.dart';
//
// import '../../../controllers/map_controller.dart';
//
// class LocationAccess extends StatefulWidget {
//   const LocationAccess({super.key});
//
//   @override
//   State<LocationAccess> createState() => _LocationAccessState();
// }
//
// class _LocationAccessState extends State<LocationAccess> {
//   MapGetXController mapGetXController = Get.put(MapGetXController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Track Location",
//           style: AllTextStyles.robotoMedium16(AppColors.blackColor),
//         ),
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: const Icon(
//             Icons.arrow_back_ios_new_sharp,
//             color: AppColors.primaryColor,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 12.0.w),
//             child: SvgPicture.asset(
//               height: 22.h,
//               "assets/notification.svg",
//               color: AppColors.primaryColor,
//             ),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 18.0.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             50.h.sh,
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                     height: 55.h,
//                     width: 245.w,
//                     decoration: BoxDecoration(
//                         color: AppColors.whiteColor,
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(0.3, 0.3),
//                           ),
//                           BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(-0.3, -0.3),
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(8.r)),
//                     child: Center(
//                       child: TextField(
//                         cursorColor: AppColors.primaryColor,
//
//                         decoration: InputDecoration(
//                           hintText: "Enter Email",
//                           filled: true,
//
//                           fillColor: AppColors.searchbarColor.withOpacity(0.16),
//                           // Background color
//                           border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.circular(8.0.r), // Rounded border
//                             borderSide: BorderSide.none, // No border
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 16.0.w, vertical: 16.h),
//                           // Padding inside the TextField
//                         ),
//                         style: const TextStyle(
//                             color: AppColors.lightGrey), // Text color
//                       ),
//                     )),
//                 GestureDetector(
//                   onTap: () {
//                     Share.share(
//                         'https://www.google.com/maps/search/?api=1&query=${mapGetXController.currentPosition.value?.latitude},${mapGetXController.currentPosition.value?.longitude}');
//                   },
//                   child: Container(
//                     height: 50.h,
//                     width: 70.w,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5.r),
//                       color: AppColors.primaryColor,
//                       boxShadow: reuseAbleShadow,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Center(
//                           child: Text(
//                             "Give",
//                             style: TextStyle(
//                                 color: AppColors.whiteColor,
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Center(
//                           child: Text(
//                             "Access",
//                             style: TextStyle(
//                                 color: AppColors.whiteColor,
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             20.h.sh,
//             Container(
//               height: 80.h,
//               width: double.maxFinite,
//               decoration: BoxDecoration(
//                   color: AppColors.primaryColorLight,
//                   borderRadius: BorderRadius.circular(10.r)),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset("assets/avator.png"),
//                     10.w.sw,
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Person Name",
//                           style: AllTextStyles.robotoSemiBold12(
//                               AppColors.blackColor),
//                         ),
//                         5.h.sh,
//                         Text(
//                           "Location",
//                           style: AllTextStyles.robotoRegular10(
//                               AppColors.lightGrey),
//                         ),
//                       ],
//                     ),
//                     Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Container(
//                         height: 30.h,
//                         width: 85.w,
//                         decoration: BoxDecoration(
//                             boxShadow: reuseAbleShadow,
//                             borderRadius: BorderRadius.circular(20.r),
//                             color: Colors.white),
//                         child: Center(
//                           child: Text(
//                             "Remove access",
//                             style: AllTextStyles.robotoRegular10(
//                                     AppColors.primaryColor)
//                                 .copyWith(fontSize: 8.sp),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             10.h.sh,
//             Container(
//               height: 80.h,
//               width: double.maxFinite,
//               decoration: BoxDecoration(
//                   color: AppColors.primaryColorLight,
//                   borderRadius: BorderRadius.circular(10.r)),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset("assets/avator.png"),
//                     10.w.sw,
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Person Name",
//                           style: AllTextStyles.robotoSemiBold12(
//                               AppColors.blackColor),
//                         ),
//                         5.h.sh,
//                         Text(
//                           "Location",
//                           style: AllTextStyles.robotoRegular10(
//                               AppColors.lightGrey),
//                         ),
//                       ],
//                     ),
//                     Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Container(
//                         height: 30.h,
//                         width: 85.w,
//                         decoration: BoxDecoration(
//                             boxShadow: reuseAbleShadow,
//                             borderRadius: BorderRadius.circular(20.r),
//                             color: Colors.white),
//                         child: Center(
//                           child: Text(
//                             "Remove access",
//                             style: AllTextStyles.robotoRegular10(
//                                     AppColors.primaryColor)
//                                 .copyWith(fontSize: 8.sp),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controllers/map_controller.dart';
import '../../../controllers/shared_prefrences/sharedpreferences.dart';
import '../../../controllers/shared_prefrences/sharedprefs_controller.dart';
import '../../widgets/constants/app_toast/rating_toast.dart';

class LocationAccess extends StatefulWidget {
  const LocationAccess({super.key});

  @override
  State<LocationAccess> createState() => _LocationAccessState();
}

class _LocationAccessState extends State<LocationAccess> {
  MapGetXController mapGetXController = Get.put(MapGetXController());
  SharedPrefsController sharedPrefsController =
      Get.put(SharedPrefsController());
  @override
  void initState() {
    mapGetXController.accessController.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        mapGetXController.isEmailFound.value = false;
        mapGetXController.searchUserName.value = "";
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Track Location",
            style: AllTextStyles.robotoMedium16(AppColors.blackColor)
                .copyWith(fontSize: 18.sp),
          ),
          leading: GestureDetector(
            onTap: () {
              mapGetXController.searchUserName.value = "";
              mapGetXController.isEmailFound.value = false;
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: AppColors.primaryColor,
            ),
          ),
          actions: [],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              50.h.sh,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 55.h,
                      width: 245.w,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.3, 0.3),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-0.3, -0.3),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Center(
                        child: TextField(
                          cursorColor: AppColors.primaryColor,
                          controller: mapGetXController.accessController,

                          decoration: InputDecoration(
                            hintText: "Enter Email",
                            filled: true,
                            fillColor:
                                AppColors.searchbarColor.withOpacity(0.16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0.r), // Rounded border
                              borderSide: BorderSide.none, // No border
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0.w, vertical: 16.h),
                          ),
                          style: const TextStyle(
                              color: AppColors.lightGrey), // Text color
                        ),
                      )),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        mapGetXController.searchUserName.value = "";
                        if (mapGetXController
                            .accessController.text.isNotEmpty) {
                          mapGetXController
                              .checkDocumentExistence(
                                  mapGetXController.accessController.text
                                      .trim()
                                      .toString(),
                                  context)
                              .then((value) {
                            if (value == "Already granted") {
                              mapGetXController.alreadyGranted.value = true;
                            } else if (value == "request Access") {
                              mapGetXController.alreadyGranted.value = false;
                            }
                          });
                        } else {
                          showAccountToast(context, "Please Enter Email Id");
                        }
                      },
                      child: Container(
                        height: 50.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColors.primaryColor,
                          boxShadow: reuseAbleShadow,
                        ),
                        child: mapGetXController.isLoading.value
                            ? Center(
                                child: Container(
                                    height: 25.h,
                                    width: 25.w,
                                    child: const CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      color: AppColors.primaryColor,
                                    )))
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Search",
                                      style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  )
                ],
              ),
              20.h.sh,
              Obx(
                () => Visibility(
                  visible: mapGetXController.isEmailFound.value,
                  child: Container(
                    height: 80.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColorLight,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Image.asset("assets/avator.png"),
                          10.w.sw,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 88.w,
                                //color: Colors.red,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  mapGetXController.searchUserName.value,
                                  style: AllTextStyles.robotoSemiBold12(
                                          AppColors.blackColor)
                                      .copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              5.h.sh,
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: mapGetXController.alreadyGranted.value
                                ? () {
                                    log("Calll ======&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&=====");
                                    mapGetXController
                                        .checkDocumentExistenceAndThenRemoved(
                                            mapGetXController
                                                .accessController.text
                                                .toString(),
                                            sharedPrefsController.email.value,
                                            context)
                                        .then((value) {
                                      mapGetXController
                                          .removeUserEmailInSharedPreferencesAlsoInList(
                                              mapGetXController
                                                  .accessController.text
                                                  .toString());
                                    }).onError((error, stackTrace) {
                                      print("Error=${error.toString()}");
                                    });
                                  }
                                : () {
                                    ///**********************************************
                                    try {
                                      FirebaseFirestore.instance
                                          .collection('user_locations')
                                          .doc(mapGetXController
                                              .accessController.text
                                              .trim()
                                              .toString())
                                          .collection('permission')
                                          .doc(
                                              sharedPrefsController.email.value)
                                          .set({
                                        "email":
                                            sharedPrefsController.email.value,
                                        "longitude": mapGetXController
                                                .currentPosition
                                                .value
                                                ?.longitude ??
                                            "",
                                        "latitude": mapGetXController
                                                .currentPosition
                                                .value
                                                ?.latitude ??
                                            "",
                                        "name":
                                            sharedPrefsController.name.value,
                                      });

                                      // mapGetXController. userLocationAccess.value =
                                      //                               SharedPrefs.preferences!.getStringList("userLocationAccess") ??
                                      //                                   [];
                                      //                           userLocationAccess.add(collectionEmail);
                                      //                           await SharedPrefs.preferences!
                                      //                               .setStringList("userLocationAccess", userLocationAccess) ??
                                      //                               [];
                                      //                           log("It Exist Not  bbbbbbbbbb");
                                      //
                                      //                           isLoading.value = false;
                                      //
                                      //
                                      // accessController.clear();
                                      showAccountToast(context,
                                          "Request To Access Successes");

                                      mapGetXController.isEmailFound.value =
                                          false;

                                      mapGetXController.isLoading.value = false;

                                      mapGetXController
                                          .setUserEmailInSharedPreferencesAlsoInList();
                                    } catch (e) {
                                      showAccountToast(context,
                                          "Something wrong Error Occurred");
                                      log("Error ===${e.toString()}");
                                    }
                                  },
                            child: Container(
                              height: 40.h,
                              width: mapGetXController.alreadyGranted.value
                                  ? 160.w
                                  : 105.w,
                              decoration: BoxDecoration(
                                  boxShadow: reuseAbleShadow,
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  mapGetXController.alreadyGranted.value
                                      ? "Already Granted Remove Access "
                                      : "Request Access",
                                  style: AllTextStyles.robotoRegular10(
                                          AppColors.primaryColor)
                                      .copyWith(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          7.w.sw,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
