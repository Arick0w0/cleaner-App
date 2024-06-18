import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/core/widgets/persentation/screen/landing_page.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/screen/home/offer_home.dart';
import 'package:mae_ban/feature/offer/presentation/screen/profile/profile.dart';

import 'screen/booking/pages/test/offer_booking_page.dart';

class JobOfferLandingPage extends StatelessWidget {
  final int initialTabIndex;

  const JobOfferLandingPage({
    this.initialTabIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return LandingPage(
            bottomNavItems: bottomNavItemsJobOffer,
            bottomNavScreens: [
              const OfferHomePage(),
              const BookingPage(),
              // OfferProfilePage(user: state.user),
              Profile(),
            ],
            initialTabIndex: initialTabIndex,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

const List<BottomNavigationBarItem> bottomNavItemsJobOffer = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  BottomNavigationBarItem(
      icon: Icon(Icons.book_online_outlined), label: "Booking"),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
];
