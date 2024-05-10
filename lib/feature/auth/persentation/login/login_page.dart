import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/auth/persentation/signup/signup_user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: MSize.defaultSize + 50,
            horizontal: 14,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  MTexts.logo,
                  // style: TextStyle(
                  //     fontFamily: 'Meticula',
                  //     fontSize: 50,
                  //     fontWeight: FontWeight.w900),
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              const Gap(MSize.spaceBtwSections),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MTexts.phoneNumber,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.start,
                  ),
                  const Gap(MSize.spaceBtwItems),

                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: MTexts.phoneNumber,
                    ),
                  ),
                  const Gap(MSize.spaceBtwSections),
                  Text(
                    MTexts.password,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.start,
                  ),
                  const Gap(MSize.spaceBtwItems),

                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: MTexts.password,
                        suffixIcon: Icon(Icons.remove_red_eye_sharp)),
                  ),
                  // const Gap(10),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          MTexts.forgotPassword,
                          // style: const TextStyle(
                          //   decoration: TextDecoration.underline,
                          //   decorationColor: MColors.lights,
                          // ).copyWith(
                          //   fontSize: 16.0,
                          //   color: MColors.lights,
                          // ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: MColors.lights,
                                  decoration: TextDecoration.underline,
                                  decorationColor: MColors.lights),
                        ),
                      ),
                    ],
                  ),
                  const Gap(MSize.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(MTexts.logIn),
                    ),
                  ),
                  const Gap(MSize.spaceBtwSections + 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpUserPage()),
                          );
                        },
                        child: Text.rich(TextSpan(children: [
                          TextSpan(
                              text: MTexts.doYouHaveAnAccount,
                              style: Theme.of(context).textTheme.bodyLarge),
                          TextSpan(
                            text: MTexts.signUp,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: MColors.lights,
                                    decoration: TextDecoration.underline,
                                    decorationColor: MColors.lights),
                          )
                        ])),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
