import 'package:mind_companion/controllers/db_controller/db_allmethod_controller.dart';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';

class MainSplash extends StatefulWidget {
  const MainSplash({super.key});

  @override
  State<MainSplash> createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {
  DBAllMethodController dbAllMethodController =
      Get.put(DBAllMethodController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dbAllMethodController.getAllTasks().then((value) {});
    });

    Future.delayed(const Duration(seconds: 6)).then((value) {
      Get.offNamed(letsGoSplash);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          130.h.sh,
          Center(child: SvgPicture.asset(height: 190.h, "assets/splash.svg")),
          20.h.sh,
          Center(
            child: Text(
              "Mind Companion",
              style: AllTextStyles.robotoSemiBold18(AppColors.primaryColor),
            ),
          ),
          const Spacer(),
          Center(
              child: Image.asset(
                  height: 100.h, width: 200.w, "assets/splash_subimg.png")),
          25.h.sh,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0.w),
            child: const Center(
              child: LinearProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          40.h.sh,
        ],
      ),
    );
  }
}
