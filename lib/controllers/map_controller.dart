import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mind_companion/controllers/shared_prefrences/sharedpreferences.dart';
import 'package:mind_companion/controllers/shared_prefrences/sharedprefs_controller.dart';
import '../view/widgets/constants/app_toast/rating_toast.dart';

class MapGetXController extends GetxController {
  SharedPrefsController sharedPrefsController =
      Get.put(SharedPrefsController());

  //For Updating Current Position Store:
  Rx<LatLng?> currentPosition = const LatLng(37.4223, -122.0848).obs;
  //For Tracing  Updating Current Position Store:
  Rx<LatLng?> traceCurrentPosition = const LatLng(37.4223, -122.0848).obs;

  ///Used For Delay Because Map Takes Little Bit Time To Show :
  RxBool isShow = false.obs;

  ///For Checking Email Found Or Not Its Used In Search Query Result
  RxBool isEmailFound = false.obs;

  ///Permission Status Checking Of Location
  Rx<LocationPermission> isAllowedPermission =
      LocationPermission.deniedForever.obs;

  //For Storing All Access the Current Login  In User Gives To Others Simple Storing Email Of Others
  RxList<String> userLocationAccessSP = <String>[].obs;

  ///using this For String  Getting Searched User Name to Show in Card:
  RxString searchUserName = "".obs;

//It is Used For Showing CircularProgress Bar on Button Is User are Trying TO Login Or SignUp
  RxBool isLoading = false.obs;
  //It is Used For Showing CircularProgress Bar on Button Is User are Trying TO Delete Any Task Or DOc
  RxBool isLoadingDocDelete = false.obs;

  //Used For String Query Result that User Have Already access or Not:
  RxBool alreadyGranted = false.obs;

  ///For Storing User Email In Sharer Preference  that he Give Access Of Location because Later updating Lat Long

  setUserEmailInSharedPreferencesAlsoInList() async {
    bool isExist = userLocationAccessSP.any(
        (element) => element == accessController.value.text.trim().toString());
    if (isExist) {
      await SharedPrefs.preferences
          ?.setStringList("Access", userLocationAccessSP);
      log("Saved Successfully in Prefrences=${accessController.value.text.trim().toString()}");
    } else {
      userLocationAccessSP.insert(
          0, accessController.value.text.trim().toString());
      await SharedPrefs.preferences
          ?.setStringList("Access", userLocationAccessSP);
      log("Saved Successfully in Prefrences=${accessController.value.text.trim().toString()}");
    }

    userLocationAccessSP.refresh();
    accessController.clear();
  }

//For Removing User Also in Sharered Preferences if Remove Access of Sharing Location
  removeUserEmailInSharedPreferencesAlsoInList(String desireEmail) async {
    log("Email TO Delete is= = $desireEmail}");
    log("Before List==${userLocationAccessSP.length}");
    userLocationAccessSP.removeWhere((element) => element == desireEmail);
    log("After List==${userLocationAccessSP.length}");
    await SharedPrefs.preferences
        ?.setStringList("Access", userLocationAccessSP);
    log("Remove Entry==$desireEmail");
    userLocationAccessSP.refresh();
  }

//For Search EMail For Location Sharing
  TextEditingController accessController = TextEditingController();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  ///For String Lal Long Of given access to other accounts:
  storingLatLong() async {
    userLocationAccessSP.forEach((element) async {
      log("Email== = $element");
      try {
        await fireStore
            .collection('user_locations')
            .doc(element)
            .collection("permission")
            .doc(sharedPrefsController.email.value)
            .set({
          'latitude': currentPosition.value?.latitude ?? "",
          'longitude': currentPosition.value?.longitude ?? "",
          'email': sharedPrefsController.email.value,
          "uid": "",
          'name': sharedPrefsController.name.value,
        });
        log("SuccessFully Uploading Lat ==${currentPosition.value?.latitude ?? ""}");
        log("SuccessFully Uploading Long ==${currentPosition.value?.longitude ?? ""}");
      } catch (e) {
        log("Error While Sending Lat Long${e.toString()}");
      }
    });
  }

//for removing access if it exist
  Future<void> checkDocumentExistenceAndThenRemoved(String userEmailForChecking,
      String collectionEmail, BuildContext context) async {
    try {
      log("Uid  Email==${sharedPrefsController.email.value}");
      log("Collection  Email==$userEmailForChecking");
      isLoadingDocDelete.value = true;
      DocumentSnapshot nestedDocumentSnapshot = await FirebaseFirestore.instance
          .collection('user_locations')
          // .doc(sharedPrefsController.email.value)
          .doc(userEmailForChecking)
          .collection('permission')
          .doc(sharedPrefsController.email.value)
          .get();
      bool nestedDocumentExists = nestedDocumentSnapshot.exists;
      if (nestedDocumentExists) {
        await FirebaseFirestore.instance
            .collection('user_locations')
            .doc(userEmailForChecking)
            .collection('permission')
            .doc(sharedPrefsController.email.value)
            .delete()
            .then((value) {
          log("Deleted Successfully");
        });
        isLoading.value = false;
        isLoadingDocDelete.value = false;

        searchUserName.value = "";
        alreadyGranted.value = false;
        isEmailFound.value = false;
      } else {
        log("Email Not Found");
        isLoadingDocDelete.value = false;
        showAccountToast(context, "Error Occured");
      }
    } catch (e) {
      isEmailFound.value = false;
      showAccountToast(context, "Error Occured");
      isLoadingDocDelete.value = false;
      accessController.clear();
      log('Error: $e');
    }
  }

//For Checking Doc Exist Or Not If Exist Then Allow Access OF Location
  Future<String> checkDocumentExistence(
      String collectionEmail, BuildContext context) async {
    try {
      log("User Collection Email==$collectionEmail");
      isLoading.value = true;
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('user_locations')
          .doc(collectionEmail)
          .get();
      if (documentSnapshot.exists) {
        searchUserName.value = documentSnapshot.get('name');
        log("SearchName = *** = ${searchUserName.value}");
        DocumentSnapshot nestedDocumentSnapshot = await FirebaseFirestore
            .instance
            .collection('user_locations')
            .doc(collectionEmail)
            .collection('permission')
            .doc(sharedPrefsController.email.value)
            .get();

        bool nestedDocumentExists = nestedDocumentSnapshot.exists;
        if (nestedDocumentExists) {
          isEmailFound.value = true;

          isLoading.value = false;
          log("Already Granted");
          return "Already granted";
        } else {
          log("Email Found Request To Access");
          isLoading.value = false;
          isEmailFound.value = true;

          return "request Access";
        }
      } else {
        showAccountToast(context, "Email Not Found");
        accessController.clear();
        log("User Not Exist= = = ");
        isLoading.value = false;
        isEmailFound.value = false;
        return "";
      }
    } catch (e) {
      isEmailFound.value = false;
      showAccountToast(context, "Result Not Foundd");
      isLoading.value = false;
      accessController.clear();
      log('Error: $e');
      return "";
    }
  }

//For Getting USer Email For CComparison
  getUserEmail() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user_locations')
        .doc(sharedPrefsController.email.value)
        .collection('permission')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      userLocationAccessSP.clear();
      querySnapshot.docs.forEach((doc) {
        log("Here is See ==${doc.id}");
        userLocationAccessSP.add(doc.id);
      });
    }

    ///
  }
}
