import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mind_companion/controllers/shared_prefrences/sharedpreferences.dart';
import 'package:mind_companion/controllers/shared_prefrences/sharedprefs_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../view/widgets/constants/app_toast/rating_toast.dart';
import '../view/widgets/reuseable_imports/resueable_imports.dart';

class SignUpController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  void signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();

      await SharedPrefs.preferences!.setBool("isLogIn", false);
      sharedPrefsController.isLoginIn.value = false;
      log("Sign Out Successfully");
      Get.offAllNamed(login);
    } catch (e) {
      log("Error signing out: $e");
    }
  }

  static openUrl(String anyUrl) async {
    final Uri url = Uri.parse(anyUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  clearingTextField() {
    firstName.clear();
    lastName.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
  }

  Rx<String> errorMessage = "".obs;

  String? validatePassword(String value) {
    if (value.isEmpty) {
      errorMessage.value = "Please enter a password";
      return 'Please enter a password';
    }
    if (value.length < 6) {
      errorMessage.value = "Please enter a password";
      return 'Password must be at least 6 characters';
    }
    // You can add more complex password validation logic if needed
    return null;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  Future<void> signUp(String firstName, String lastName, String email,
      String password, BuildContext context) async {
    try {
      isLoading.value = true;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      await fireStore
          .collection('users')
          .doc(email)
          .set({'name': firstName + lastName, 'email': email, 'uid': uid});

      isLoading.value = false;

      showAccountToast(context, "Account Created Successfully");
      clearingTextField();
      Get.offNamed(login);
    } catch (error) {
      isLoading.value = false;
      log('Error during signup: $error');
      showAccountToast(context, "Error Occurred");
    }
  }

  SharedPrefsController sharedPrefsController =
      Get.put(SharedPrefsController());

  //Login::
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      isLoading.value = true;

      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      sharedPrefsController.isLoginIn.value =
          await SharedPrefs.preferences!.setBool("isLogIn", true);

      isLoading.value = false;

      // Navigate to your home or dashboard screen after successful login
      Get.offNamed(homeScreen);
    } catch (error) {
      isLoading.value = false;
      sharedPrefsController.isLoginIn.value =
          await SharedPrefs.preferences!.setBool("isLogIn", false);
      log("...Login In User in LoginMethode = = = ${sharedPrefsController.isLoginIn.value}");
      log('Error during login: $error');
      showAccountToast(context, "Login Failed. Check your email and password.");
    }
  }
}
