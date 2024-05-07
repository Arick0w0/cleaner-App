import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mPrimaryColor,
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: mDefaultSize + 50,
          horizontal: 14,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                mLogo,
                // style: Theme.of(context).textTheme.titleLarge,
                style: TextStyle(
                    fontFamily: 'Meticula',
                    fontSize: 50,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mForgotPassword,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: mFormHeight - 15),
                TextFormField(
                  style: const TextStyle(color: mSecondaryColor),
                  decoration: InputDecoration(
                    hintText: mPhoneNumber,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // TextFormField(
                //   style: const TextStyle(color: mSecondaryColor),
                //   decoration: InputDecoration(
                //     hintText: mPassword,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(5.0),
                //     ),
                //   ),
                // ),

                TextFormField(
                  style: const TextStyle(color: mSecondaryColor),
                  decoration: InputDecoration(
                    hintText: mPassword,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
