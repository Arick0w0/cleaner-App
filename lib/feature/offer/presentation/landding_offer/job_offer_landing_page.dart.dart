import 'package:flutter/material.dart';
import 'package:mae_ban/core/widgets/presentation/screen/landing_page.dart';
import 'package:mae_ban/feature/offer/presentation/screen/home_page/offer_home.dart';
import 'package:mae_ban/feature/offer/presentation/screen/profile_page/profile.dart';
import 'offer_booking_page.dart';

class JobOfferLandingPage extends StatelessWidget {
  final int initialTabIndex;
  final int initialActivityTabIndex;

  const JobOfferLandingPage({
    this.initialTabIndex = 0,
    this.initialActivityTabIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LandingPage(
      bottomNavItems: bottomNavItemsJobOffer,
      bottomNavScreens: [
        const OfferHomePage(),
        BookingPage(initialIndex: initialActivityTabIndex),
        const Profile(),
      ],
      initialTabIndex: initialTabIndex,
    );
  }
}

const List<BottomNavigationBarItem> bottomNavItemsJobOffer = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "ໜ້າຫຼັກ"),
  BottomNavigationBarItem(
      icon: Icon(Icons.book_online_outlined), label: "ການຈອງ"),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: "ໂປຣໄຟລ໌"),
];
