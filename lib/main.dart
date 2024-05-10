import 'package:flutter/material.dart';
import 'package:mae_ban/core/theme/them.dart';
import 'package:mae_ban/feature/auth/persentation/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MAppTheme.lightTheme,
      // home: const SelectRadio(
      //   title: 'Radio',
      // ),
      home: const LoginPage(),
    );
  }
}
