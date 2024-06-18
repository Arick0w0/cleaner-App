import 'package:flutter/material.dart';
import 'package:mae_ban/core/utils/auth_utils.dart';

class HunterProfile extends StatelessWidget {
  const HunterProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hunter Profile')),
        body: Column(
          children: [
            GestureDetector(
                onTap: () => logout(context),
                child: const Text('Offer Profile'))
          ],
        ));
  }
}
