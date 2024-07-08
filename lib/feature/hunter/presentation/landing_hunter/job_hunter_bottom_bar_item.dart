import 'package:flutter/material.dart';
import 'package:mae_ban/core/widgets/presentation/screen/landing_page.dart';
import 'package:mae_ban/feature/hunter/presentation/landing_hunter/ativity_tap_bar_view.dart';
import 'package:mae_ban/feature/hunter/presentation/profile_page/profile_hunter_page.dart';

class JobHunterLandingPage extends StatelessWidget {
  final int initialTabIndex;
  final int initialActivityTabIndex;

  const JobHunterLandingPage({
    super.key,
    this.initialTabIndex = 0,
    this.initialActivityTabIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LandingPage(
      bottomNavItems: bottomNavItemsJobHunter,
      bottomNavScreens: [
        ActivityViewPage(initialIndex: initialActivityTabIndex),
        const HunterProfile(),
      ],
      initialTabIndex: initialTabIndex,
    );
  }
}

const List<BottomNavigationBarItem> bottomNavItemsJobHunter = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "ໜ້າຫຼັກ"),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: "ໂປຣໄຟລ໌"),
];
