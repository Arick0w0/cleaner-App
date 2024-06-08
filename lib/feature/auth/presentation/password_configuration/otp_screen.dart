import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/auth/presentation/password_configuration/reset_password_screen.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OtpFieldController otpController = OtpFieldController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 150),
          child: Column(children: [
            Text(
              MTexts.confirmOtp,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Gap(40),
            OTPTextField(
              controller: otpController,
              length: 5,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 45,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 15,
              style: const TextStyle(fontSize: 17),
              onChanged: (pin) {
                print("Changed: " + pin);
              },
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            Gap(MSize.defaultSize),
            TextButton(
              onPressed: () {},
              child: Text(
                "send Again",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: MColors.accent,
                    decoration: TextDecoration.underline,
                    decorationColor: MColors.lights),
              ),
            ),
            const Gap(MSize.spaceBtwSections),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen(
                                userId: '',
                                token: '',
                              )));
                },
                child: const Text("send"),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
