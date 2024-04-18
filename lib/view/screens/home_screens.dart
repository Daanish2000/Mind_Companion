import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/map_controller.dart';
import '../../controllers/shared_prefrences/sharedpreferences.dart';
import '../../controllers/shared_prefrences/sharedprefs_controller.dart';
import '../../controllers/signup_controller.dart';
import '../../model/bottom_navbar_model.dart';
import '../widgets/dialogs/rating_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  SharedPrefsController sharedPrefsController =
      Get.put(SharedPrefsController());
  SignUpController signUpController = Get.put(SignUpController());
  MapGetXController mapGetXController = Get.put(MapGetXController());
  var currentIndex = 0;
  @override
  void initState() {
    log("Controller Value===${signUpController.isLoading.value}");

    homeController.getUserName();
    mapGetXController.userLocationAccessSP.value =
        SharedPrefs.preferences!.getStringList("Access") ?? [];

    mapGetXController.userLocationAccessSP.forEach((element) {
      log("Data==$element");
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0) {
          showDialog(
              context: context,
              builder: (context) {
                return RatingDialog();
              });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            elevation: 0,
            // leading: Padding(
            //   padding: EdgeInsets.only(left: 20.0.w, right: 10.w),
            //   child: GestureDetector(
            //     onTap: () {
            //       //Get.toNamed(profile);
            //     },
            //     child: SvgPicture.asset(
            //         height: 10.h, width: 10.w, "assets/drawer.svg"),
            //   ),
            // ),
            backgroundColor: AppColors.whiteColor,
            iconTheme:
                IconThemeData(color: AppColors.primaryColor, size: 30.sp),
            title: Text(currentIndex == 0 ? "Mind companion" : "Profile"),
            centerTitle: true,
            actions: [
              // Padding(
              //   padding: EdgeInsets.only(right: 15.0.w),
              //   child: SvgPicture.asset("assets/noti.svg"),
              // ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            child: SvgPicture.asset(height: 25.h, "assets/add.svg"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddTaskDialog(
                      newTask: 'New Task',
                      repeatTask: 'Repeat Task',
                      addTask: () {
                        Get.offNamed(addNewTask);
                      },
                      repeatedTask: () {
                        Get.offNamed(repeatTask);
                      },
                    );
                  });
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              final color =
                  isActive ? AppColors.primaryColor : AppColors.blackColor;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconList[index].icons,
                    size: 24,
                    color: color,
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      iconList[index].label,
                      maxLines: 1,
                      style: TextStyle(color: color),
                    ),
                  )
                ],
              );
            },
            backgroundColor: Colors.white.withOpacity(0.9),
            activeIndex: currentIndex,
            splashColor: Colors.greenAccent,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.defaultEdge,
            gapLocation: GapLocation.center,
            onTap: (index) => setState(() => currentIndex = index),
            shadow: BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 12,
              spreadRadius: 0.5,
              color: AppColors.primaryColor.withOpacity(0.25),
            ),
          ),
          body: pages[currentIndex]),
    );
  }
}
