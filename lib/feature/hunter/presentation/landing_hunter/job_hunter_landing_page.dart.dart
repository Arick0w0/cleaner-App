import 'package:flutter/material.dart';
import 'package:mae_ban/core/widgets/persentation/screen/landing_page.dart';
import 'package:mae_ban/feature/hunter/presentation/landing_hunter/ativity_view_page.dart';
import 'package:mae_ban/feature/hunter/presentation/profile_page/profile_hunter_page.dart';

class JobHunterLandingPage extends StatelessWidget {
  final int initialTabIndex;

  const JobHunterLandingPage({
    Key? key,
    this.initialTabIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LandingPage(
      // role: user.role,
      bottomNavItems: bottomNavItemsJobHunter,
      bottomNavScreens: bottomNavScreensJobHunter(initialTabIndex),
      // user: user,
    );
  }
}

const List<BottomNavigationBarItem> bottomNavItemsJobHunter = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  // BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
  BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
];

List<Widget> bottomNavScreensJobHunter(int initialTabIndex) {
  return [
    ActivityViewPage(initialIndex: initialTabIndex),
    // Text('Job Hunter Search'),
    HunterProfile(), // Placeholder for actual profile widget
  ];
}
