import '../view/widgets/reuseable_imports/resueable_imports.dart';

class LoginController extends GetxController {
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  clearingLoginTextField() {
    loginEmail.clear();
    loginPassword.clear();
  }
}
