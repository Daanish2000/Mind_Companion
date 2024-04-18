import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view/widgets/reuseable_imports/resueable_imports.dart';

class FeedBackController extends GetxController {
  TextEditingController subject = TextEditingController();

  TextEditingController description = TextEditingController();

  Future<void> openEmail() async {
    String emails = Uri.encodeComponent("amjadkhandev5426@gmail.com");
    String subjects = Uri.encodeComponent(subject.text.trim().toString());
    String body = Uri.encodeComponent(description.text.trim().toString());
    print(subject); //output: Hello%20Flutter
    Uri mail = Uri.parse("mailto:$emails?subject=$subjects&body=$body");

    if (await launchUrl(mail)) {
    } else {
      //email app is not opened
    }
  }
}
