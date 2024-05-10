import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/auth/persentation/signup/signup_hunter.dart';

class SignUpUserPage extends StatelessWidget {
  const SignUpUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MTexts.signUp),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: MSize.spaceBtwSections,
            horizontal: 14,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MTexts.inputPersonalInfo,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // const Gap(MSize.spaceBtwItems),
              const Gap(MSize.defaultSpace),

              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: MTexts.firstName,
                ),
              ),
              const Gap(MSize.spaceBtwItems),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: MTexts.lastName,
                ),
              ),
              // const Gap(MSize.defaultSpace),

              // Row(
              //   children: [
              //     CheckboxWidget(),
              //     Text(
              //       MTexts.men,
              //       style: Theme.of(context).textTheme.titleLarge,
              //     ),
              //     CheckboxWidget(),
              //     Text(
              //       MTexts.women,
              //       style: Theme.of(context).textTheme.titleLarge,
              //     ),
              //   ],
              // ),

              Text(
                MTexts.loginPassword,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
// Row(children: [Checkbox(value: , onChanged: (){})],),

              const Gap(MSize.defaultSpace),
              // const Gap(MSize.spaceBtwItems + 5),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: MTexts.phoneNumber,
                ),
              ),
              const Gap(MSize.spaceBtwItems),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: MTexts.password,
                ),
              ),
              const Gap(MSize.spaceBtwItems),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: MTexts.confirmPassword,
                ),
              ),
              const Gap(MSize.spaceBtwSections + 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(MTexts.signUp),
                ),
              ),
              const Gap(MSize.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpHunterPage()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          const TextSpan(
                            text: MTexts.doYouWantTosigUpHunter,
                          ),
                          TextSpan(
                              text: MTexts.hunter,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: MColors.accent,
                              ).copyWith(color: MColors.accent)),
                          const TextSpan(text: MTexts.sure)
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      // child: Text(MTexts.signUp),
    );
  }
}
