import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/core/utils/show_snackbar.dart';
import 'package:mae_ban/core/widgets/loader.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/password_text_form_field.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/text_form_field.dart';
import 'package:mae_ban/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart'; // Import UserCubit

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SharedPreferences sharedPreferences = sl<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthFailure) {
              showSnackBar(
                context,
                state.error,
                backgroundColor: MColors.indianred,
              );
            } else if (state is AuthSuccess) {
              showSnackBar(
                backgroundColor: MColors.emerald,
                context,
                MTexts.loginSuccess,
              );

              final authResponse = state.authResponse;
              await sharedPreferences.setString(
                  'accessToken', authResponse?.accessToken ?? '');
              await sharedPreferences.setString(
                  'refreshToken', authResponse?.refreshToken ?? '');
              await sharedPreferences.setString(
                  'role', authResponse?.role ?? 'unknown');
              await sharedPreferences.setString(
                  'username', usernameController.text);

              final role = authResponse?.role ?? 'unknown';
              final token = authResponse?.accessToken ?? '';
              final username = usernameController.text;

              print('User role: $role'); // Debugging line

              if (role == 'JOB_OFFER') {
                context.go('/home-job-offer', extra: {
                  'username': username,
                  'token': token,
                  'role': role,
                });
              } else if (role == 'JOB_HUNTER') {
                context.go('/home-job-hunter', extra: {
                  'username': username,
                  'token': token,
                  'role': role,
                });
              } else {
                showSnackBar(context, 'Unknown role: $role');
              }
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: MSize.defaultSize + 50,
                  horizontal: 14,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Image.asset(MTexts.logo),
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
                          CustomTextFormField(
                            controller: usernameController,
                            labelText: MTexts.phoneNumber,
                            prefixIcon: const Icon(Icons.phone),
                            usePrefix: true, // Set the prefix to 020
                            keyboardType: TextInputType.phone,
                            useMaxLength: true, // Enable max length
                            errorText: MTexts.pleaseenteryourphonenumber,
                          ),
                          const Gap(MSize.spaceBtwSections),
                          Text(
                            MTexts.password,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.start,
                          ),
                          const Gap(MSize.spaceBtwItems),
                          PasswordTextFormField(
                            controller: passwordController,
                            labelText: MTexts.password,
                            error: MTexts.plsenterpassword,
                            icon: const Icon(Icons.password),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.push('/forgot-password');
                                },
                                child: Text(
                                  MTexts.forgotPassword,
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final usernameWithPrefix =
                                      '20${usernameController.text}';
                                  context.read<AuthBloc>().add(
                                        LoginEvent(
                                          usernameWithPrefix,
                                          passwordController.text,
                                          context.read<
                                              UserCubit>(), // Pass UserCubit here
                                        ),
                                      );
                                }
                              },
                              child: const Text(MTexts.logIn),
                            ),
                          ),
                          const Gap(MSize.spaceBtwSections + 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.push('/sign-up-offer');
                                },
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: MTexts.doYouHaveAnAccount,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  TextSpan(
                                    text: MTexts.signUp,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: MColors.lights,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: MColors.lights),
                                  )
                                ])),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.push('/sign-up-job-hunter');
                                },
                                child: Text.rich(
                                  TextSpan(
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    children: [
                                      const TextSpan(
                                        text: MTexts.doYouWantTosigUpHunter,
                                      ),
                                      TextSpan(
                                        text: MTexts.hunter,
                                        style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: MColors.accent,
                                        ).copyWith(color: MColors.accent),
                                      ),
                                      const TextSpan(text: MTexts.sure),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
