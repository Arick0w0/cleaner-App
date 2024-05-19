import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/feature/auth/persentation/login/login_page.dart';
import 'package:mae_ban/feature/auth/persentation/signup/signup_hunter.dart';
import 'package:mae_ban/feature/auth/persentation/signup/signup_user.dart';
import 'package:mae_ban/feature/home/persentation/hunter_page/hunter_home_page.dart';
import 'package:mae_ban/feature/home/persentation/offer_page/offer_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => FutureBuilder(
        future: _getInitialPage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return snapshot.data as Widget;
          }
        },
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/sign-up-offer',
      builder: (context, state) => SignUpOfferPage(),
    ),
    GoRoute(
      path: '/sign-up-job-hunter',
      builder: (context, state) => SignUpHunterPage(),
    ),
    GoRoute(
      path: '/home-job-offer',
      builder: (context, state) => OfferHomePage(),
    ),
    GoRoute(
      path: '/home-job-hunter',
      builder: (context, state) => HunterHomePage(),
    ),
    // GoRoute(
    //   path: '/success',
    //   builder: (context, state) => SuccessPage(),
    // ),
    // GoRoute(
    //   path: '/reset-password',
    //   builder: (context, state) => ResetPasswordPage(),
    // ),
  ],
);

Future<Widget> _getInitialPage() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final String? role = sharedPreferences.getString('role');

  if (role == 'JOB_OFFER') {
    return OfferHomePage();
  } else if (role == 'JOB_HUNTER') {
    return HunterHomePage();
  } else {
    return LoginPage();
  }
}
