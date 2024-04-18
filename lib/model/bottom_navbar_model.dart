import 'package:mind_companion/view/screens/profile_screen.dart';
import '../view/screens/secondry_home_screens.dart';
import '../view/widgets/reuseable_imports/resueable_imports.dart';

//Model For Bottom Nav Bar
class BottomNavBarModel {
  String label;
  IconData icons;
  BottomNavBarModel({required this.label, required this.icons});
}

final iconList = <BottomNavBarModel>[
  BottomNavBarModel(label: 'Home', icons: Icons.home),
  BottomNavBarModel(label: 'Profile', icons: Icons.person),
];
final List<Widget> pages = [
  const SecondryHomeScreen(),
  const ProfileScreen(),
];
