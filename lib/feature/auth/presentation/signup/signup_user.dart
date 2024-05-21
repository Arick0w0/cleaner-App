import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/core/utils/show_snackbar.dart';
import 'package:mae_ban/core/widgets/loader.dart';
import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/obscure_text_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/gender_selection_widget.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/password_match.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/text_form_field.dart';
import 'package:mae_ban/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpOfferPage extends StatefulWidget {
  const SignUpOfferPage({super.key});

  @override
  State<SignUpOfferPage> createState() => _SignUpOfferPageState();
}

class _SignUpOfferPageState extends State<SignUpOfferPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => GenderSelectionCubit()),
      ],
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(
              context,
              'Signup failed: ${state.error}',
              backgroundColor: MColors.indianred,
            );
          } else if (state is AuthSuccess) {
            showSnackBar(
              context,
              MTexts.signUpSuccess,
              backgroundColor: MColors.emerald,
            );
            context.go('/home-job-offer');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MTexts.inputPersonalInfo,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Gap(MSize.defaultSpace),
                      CustomTextFormField(
                        controller: firstNameController,
                        labelText: MTexts.firstName,
                        prefixIcon: const Icon(Icons.person),
                        errorText: MTexts.pleaseenteryourfirstname,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: lastNameController,
                        labelText: MTexts.lastName,
                        prefixIcon: const Icon(Icons.person),
                        errorText: MTexts.pleaseenteryourlastname,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      const GenderSelectionWidget(),
                      const Gap(MSize.defaultSpace),
                      Text(
                        MTexts.loginPassword,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Gap(MSize.defaultSpace),
                      CustomTextFormField(
                        controller: usernameController,
                        labelText: MTexts.phoneNumber,
                        prefixIcon: const Icon(Icons.phone),
                        keyboardType: TextInputType.phone,
                        errorText: MTexts.pleaseenteryourphonenumber,
                        useMaxLength: true,
                        usePrefix: true, // Show prefix
                      ),
                      const Gap(MSize.spaceBtwItems),
                      PasswordMatch(
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      const Gap(MSize.spaceBtwSections + 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final usernameWithPrefix =
                                  '20${usernameController.text}';
                              final gender =
                                  context.read<GenderSelectionCubit>().state;
                              print(
                                  'Selected Gender: $gender'); // Debug statement

                              final jobOffer = JobOfferModel(
                                username: usernameWithPrefix,
                                password: passwordController.text,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                gender: gender,
                              );

                              print('JobOffer: $jobOffer'); // Debug statement

                              context
                                  .read<AuthBloc>()
                                  .add(SignupJobOfferEvent(jobOffer));
                            }
                          },
                          child: const Text(MTexts.signUp),
                        ),
                      ),
                      const Gap(MSize.spaceBtwSections),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.push('/sign-up-job-hunter');
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
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
