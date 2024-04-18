import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  RxBool rated = false.obs;

  void updateRatedValue(bool newValue) {
    rated.value = newValue;
  }

  RxInt rating = 0.obs;

  updateRating(int ratings) {
    rating.value = ratings;
  }

  openAppReview(bool isDrawer) async {
    final InAppReview inAppReview = InAppReview.instance;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await inAppReview.isAvailable()) {
      inAppReview
          .openStoreListing(
            appStoreId: '...',
            microsoftStoreId: '...',
          )
          .then((value) {});
    }
  }
}
