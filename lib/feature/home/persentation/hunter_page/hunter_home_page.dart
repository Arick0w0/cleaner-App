import 'package:flutter/material.dart';
import 'package:mae_ban/core/utils/auth_utils.dart';

class HunterHomePage extends StatelessWidget {
  const HunterHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Job Hunter'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Job Hunter Home Page!'),
      ),
    );
  }
}
