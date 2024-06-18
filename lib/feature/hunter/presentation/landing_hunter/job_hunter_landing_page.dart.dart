import 'package:flutter/material.dart';
import 'package:mae_ban/core/widgets/persentation/screen/landing_page.dart';
import 'package:mae_ban/feature/auth/data/models/user_model.dart';
import 'package:mae_ban/feature/hunter/presentation/home.dart';

class JobHunterLandingPage extends StatelessWidget {
  // final User user;

  const JobHunterLandingPage({
    // required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LandingPage(
      // role: user.role,
      bottomNavItems: bottomNavItemsJobHunter,
      bottomNavScreens: bottomNavScreensJobHunter,
      // user: user,
    );
  }
}

const List<BottomNavigationBarItem> bottomNavItemsJobHunter = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
  BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
];

const List<Widget> bottomNavScreensJobHunter = [
  Text('Job Hunter Home'),
  Text('Job Hunter Search'),
  HunterProfile(), // Placeholder for actual profile widget
];
