import 'package:flutter/material.dart';
import 'package:mae_ban/core/utils/auth_utils.dart';

class OfferHomePage extends StatelessWidget {
  const OfferHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Job Offer'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Job Offer Home Page!'),
      ),
    );
  }
}
