import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/activity/booking_cubit.dart';
import 'package:mae_ban/feature/hunter/presentation/cubit/start_job/start_job_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/service_type/service_type_bloc.dart';
import 'package:mae_ban/service_locator.dart' as di;
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';
import 'app_routes.dart';
import 'core/theme/them.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:mae_ban/feature/auth/data/models/user_model.dart';

import 'feature/hunter/presentation/cubit/history/history_cubit.dart';
import 'feature/hunter/presentation/cubit/job_detail/job_detail_cubit.dart';
import 'feature/offer/presentation/cubits/booking/bookings_cubit.dart';
import 'feature/offer/presentation/cubits/choose/choose_cubit.dart';
import 'feature/offer/presentation/cubits/countdown/countdown_cubit.dart';
import 'feature/offer/presentation/cubits/generate_bill/billing_cubit.dart';
import 'feature/offer/presentation/cubits/historyuser/history_user_cubit.dart';
import 'feature/offer/presentation/cubits/job_post/job_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
      'th'); // เรียกใช้ initializeDateFormatting สำหรับภาษาไทย
  await di.init();

  final userCubit = di.sl<UserCubit>();
  await _loadUserFromPreferences(userCubit); // Load user data from preferences

  runApp(MyApp(userCubit: userCubit));
}

Future<void> _loadUserFromPreferences(UserCubit userCubit) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final userJson = sharedPreferences.getString('user');
  if (userJson != null) {
    Map<String, dynamic> userMap = jsonDecode(userJson);
    final user = User.fromJson(userMap);
    userCubit.saveUser(user); // Save user data to UserCubit
  }
}

class MyApp extends StatelessWidget {
  final UserCubit userCubit;

  const MyApp({required this.userCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>()),
        BlocProvider<ServiceTypeBloc>(
          create: (context) =>
              di.sl<ServiceTypeBloc>()..add(FetchServiceTypes()),
        ),

        BlocProvider<UserCubit>(create: (context) => userCubit),
        BlocProvider(create: (context) => CountdownCubit()),
        BlocProvider(create: (_) => di.sl<BookingCubit>()),
        BlocProvider(create: (_) => di.sl<MyBookingCubit>()),

        BlocProvider(create: (_) => di.sl<JobDetailCubit>()),
        BlocProvider(create: (_) => di.sl<HistoryCubit>()),
        BlocProvider(create: (_) => di.sl<HistoryUserCubit>()),
        BlocProvider(create: (_) => di.sl<BillingCubit>()),
        BlocProvider(create: (_) => di.sl<JobCubit>()), // Add JobCubit here
        BlocProvider(create: (_) => di.sl<ChooseCubit>()), // Add JobCubit here

        BlocProvider(
            create: (_) => di.sl<StartJobCubit>()), // Add StartJobCubit
        // BlocProvider<PostJobCubit>(
        //   create: (context) =>
        //       PostJobCubit()..clearPostJobIdsOlderThan(const Duration(days: 7)),
        // ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: MAppTheme.lightTheme,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
