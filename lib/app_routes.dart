import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/feature/auth/presentation/login/login_page.dart';
import 'package:mae_ban/feature/auth/presentation/signup/signup_hunter.dart';
import 'package:mae_ban/feature/auth/presentation/signup/signup_user.dart';
import 'package:mae_ban/feature/auth/presentation/otp/forgot_password_page.dart';
import 'package:mae_ban/feature/auth/presentation/otp/otp_screen.dart';
import 'package:mae_ban/feature/auth/presentation/otp/reset_password_screen.dart';
import 'package:mae_ban/feature/hunter/presentation/landing_hunter/job_hunter_landing_page.dart.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/pages/start_jop.dart';

import 'package:mae_ban/feature/offer/presentation/screen/home/service_form_page/service_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:mae_ban/feature/auth/data/models/user_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mae_ban/core/widgets/loader.dart';

import 'feature/auth/presentation/cubit/user_cubit.dart';
import 'feature/offer/domain/entities/service_type.dart';
import 'feature/offer/presentation/job_offer_landing_page.dart.dart';
import 'feature/offer/presentation/screen/booking/pages/offer_ativity_page.dart';
import 'feature/offer/presentation/screen/booking/pages/review_page.dart';
import 'feature/offer/presentation/screen/booking/pages/time_line_page.dart';
import 'feature/offer/presentation/screen/home/service_form_page/detail_page.dart';

Future<User?> _loadUserFromPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final userJson = sharedPreferences.getString('user');
  if (userJson != null) {
    Map<String, dynamic> userMap = jsonDecode(userJson);
    return User.fromJson(userMap);
  }
  return null;
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => FutureBuilder(
        future: _getInitialPage(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Loader());
          } else if (snapshot.hasData) {
            return snapshot.data as Widget;
          } else {
            return const LoginPage();
          }
        },
      ),
    ),
    // GoRoute(
    //   path: '/track-services',
    //   builder: (context, state) => StartJob(startJobId: '',),
    // ),
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => StepperDemo(),
    // ),
    GoRoute(
      path: '/review-page',
      builder: (context, state) => const ReviewPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/sign-up-offer',
      builder: (context, state) => const SignUpOfferPage(),
    ),
    GoRoute(
      path: '/sign-up-job-hunter',
      builder: (context, state) => const SignUpHunterPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final extra = state.extra as Map<String, String>?;
        if (extra == null ||
            !extra.containsKey('phoneNumber') ||
            !extra.containsKey('bearerToken')) {
          throw Exception(
              'Expected Map<String, String> with phoneNumber and bearerToken');
        }
        return OtpScreen(
          phoneNumber: extra['phoneNumber']!,
          bearerToken: extra['bearerToken']!,
        );
      },
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) {
        final extra = state.extra as Map<String, String>?;
        if (extra == null ||
            !extra.containsKey('userId') ||
            !extra.containsKey('token')) {
          throw Exception('Expected Map<String, String> with userId and token');
        }
        return ResetPasswordScreen(
          userId: extra['userId']!,
          token: extra['token']!,
        );
      },
    ),
    GoRoute(
      path: '/home-job-offer',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final initialTabIndex = extra?['initialTabIndex'] as int? ?? 0;
        return JobOfferLandingPage(initialTabIndex: initialTabIndex);
      },
    ),
    GoRoute(
      path: '/home-job-hunter',
      builder: (context, state) => const JobHunterLandingPage(),
    ),
    GoRoute(
      path: '/service-form',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        if (extra == null || !extra.containsKey('service')) {
          throw Exception('Expected Map<String, dynamic> with service');
        }
        final service = extra['service'] as ServiceType;

        return ServiceFormPage(service: service);
      },
    ),

    GoRoute(
      path: '/activity-page',
      builder: (context, state) => const ActivityPage(),
    ),

    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final postJobId = state.extra as String;
        return DetailPage(postJobId: postJobId);
      },
    ),
  ],
);

Future<Widget> _getInitialPage(BuildContext context) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final String? token = sharedPreferences.getString('accessToken');
  final String? role = sharedPreferences.getString('role');

  if (token != null && role != null) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    User user = User.fromJson(decodedToken);

    final userCubit = context.read<UserCubit>();
    userCubit.saveUser(user);

    if (role == 'JOB_OFFER') {
      return const JobOfferLandingPage();
    } else if (role == 'JOB_HUNTER') {
      return const JobHunterLandingPage();
    } else {
      return const LoginPage();
    }
  } else {
    return const LoginPage();
  }
}
