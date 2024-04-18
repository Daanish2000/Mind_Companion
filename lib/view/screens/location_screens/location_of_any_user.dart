import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mind_companion/view/widgets/reuseable_imports/resueable_imports.dart';
import '../../../controllers/map_controller.dart';

class LocationOfUser extends StatefulWidget {
  const LocationOfUser({super.key});

  @override
  State<LocationOfUser> createState() => _LocationOfUserState();
}

class _LocationOfUserState extends State<LocationOfUser> {
  final Completer<GoogleMapController> _controller = Completer();
  MapGetXController mapGetXController = Get.put(MapGetXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "User Location",
          style: AllTextStyles.robotoMedium16(AppColors.blackColor)
              .copyWith(fontSize: 17.sp),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 12.0.w),
          //   child: SvgPicture.asset(
          //     height: 22.h,
          //     "assets/notification.svg",
          //     color: AppColors.primaryColor,
          //   ),
          // )
        ],
      ),
      body: Obx(
        () => GoogleMap(
            initialCameraPosition: CameraPosition(
              target: mapGetXController.currentPosition.value!,
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            zoomControlsEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: mapGetXController.traceCurrentPosition.value!,
                infoWindow: InfoWindow(
                    onTap: () {
                      Get.toNamed(trackLocation);
                    },
                    title: 'Current Location'),
              ),
            }),
      ),
    );
  }
}
