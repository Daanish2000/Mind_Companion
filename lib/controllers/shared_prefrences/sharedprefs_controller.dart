import 'package:get/get.dart';

class SharedPrefsController extends GetxController {
  RxBool isLoginIn = false.obs;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString uid = "".obs;
  RxBool delay = false.obs;
}
