import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mind_companion/controllers/shared_prefrences/sharedprefs_controller.dart';

import '../view/widgets/reuseable_imports/resueable_imports.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  SharedPrefsController sharedPrefsController =
      Get.put(SharedPrefsController());

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance; // Firebase Auth instance

  Future<void> getUserName() async {
    try {
      User? user = auth.currentUser; // G
      sharedPrefsController.email.value = user?.email ?? "";
      String userUid = user?.uid ?? "";

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(sharedPrefsController.email.value)
          .get();

      if (documentSnapshot.exists) {
        var name = documentSnapshot.get('name');
        if (name != null) {
          sharedPrefsController.name.value = name;
          log("Name =* * = $name");
        } else {
          log('Warning: "name" field not found for user $userUid');
        }
      } else {
        log('Warning: User document not found for uid: $userUid');
      }
    } catch (error) {
      log('Error getting user name: $error');
    }
  }
}
