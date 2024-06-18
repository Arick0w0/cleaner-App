import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/service_type/service_type_bloc.dart';
import 'package:mae_ban/service_locator.dart' as di;
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';
import 'app_routes.dart';
import 'core/theme/them.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:mae_ban/feature/auth/data/models/user_model.dart';

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
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<ServiceTypeBloc>(
          create: (context) =>
              di.sl<ServiceTypeBloc>()..add(FetchServiceTypes()),
        ),
        BlocProvider<UserCubit>(
          create: (context) => userCubit,
        ),
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
