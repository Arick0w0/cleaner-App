import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/core/utils/show_snackbar.dart';
import 'package:mae_ban/core/widgets/loader.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/persentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/auth/persentation/widgets/passwordmath.dart';
import 'package:mae_ban/feature/auth/persentation/widgets/text_form_field.dart';
import 'package:mae_ban/feature/auth/persentation/widgets/image_picker_widget.dart';
import 'package:mae_ban/service_locator.dart';

class SignUpHunterPage extends StatefulWidget {
  const SignUpHunterPage({super.key});

  @override
  State<SignUpHunterPage> createState() => _SignUpHunterPageState();
}

class _SignUpHunterPageState extends State<SignUpHunterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController careerController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();

  final ImagePickerController idCardImageController = ImagePickerController();
  final ImagePickerController selfImageController = ImagePickerController();

  String gender = 'MALE';

  bool _validateImages() {
    if (idCardImageController.file == null) {
      return false;
    }
    if (selfImageController.file == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(MTexts.signUpHunter),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, 'Signup failed: ${state.error}',
                  backgroundColor: Colors.red);
            } else if (state is AuthSuccess) {
              showSnackBar(context, 'Signup successful',
                  backgroundColor: Colors.green);
              context.go('/home-job-hunter');
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Loader(); // Ensure Loader widget does not show the AppBar
            }
            return SingleChildScrollView(
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
                        MTexts.photoandid,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      ImagePickerWidget(
                        title: 'Tap to select self ID Card Image',
                        controller: selfImageController,
                        borderRadius: BorderRadius.circular(16),
                        errorText: 'Please select an ID card image',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      Text(
                        MTexts.idCard,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      ImagePickerWidget(
                        title: 'Tap to select ID card',
                        controller: idCardImageController,
                        borderRadius: BorderRadius.circular(16),
                        errorText: 'Please select a photo ID',
                      ),
                      const Gap(MSize.spaceBtwSections),
                      Text(
                        MTexts.inputPersonalInfo,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            fillColor:
                                MaterialStateProperty.all(MColors.secondary),
                            value: 'MALE',
                            groupValue: gender,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                          Text(MTexts.men,
                              style: Theme.of(context).textTheme.bodyLarge),
                          Radio<String>(
                            value: 'FEMALE',
                            fillColor:
                                MaterialStateProperty.all(MColors.secondary),
                            groupValue: gender,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                          Text(MTexts.women,
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: firstNameController,
                        labelText: MTexts.firstName,
                        prefixIcon: const Icon(Icons.person),
                        errorText: 'Please enter your first name',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: lastNameController,
                        labelText: MTexts.lastName,
                        prefixIcon: const Icon(Icons.person),
                        errorText: 'Please enter your last name',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: birthDateController,
                        labelText: MTexts.date,
                        prefixIcon: const Icon(Icons.calendar_today),
                        errorText: 'Please enter your birthday',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: villageController,
                        labelText: MTexts.village,
                        prefixIcon: const Icon(Icons.home),
                        errorText: 'Please enter your village',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: districtController,
                        labelText: MTexts.district,
                        prefixIcon: const Icon(Icons.location_city),
                        errorText: 'Please enter your district',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: provinceController,
                        labelText: MTexts.province,
                        prefixIcon: const Icon(Icons.location_city_sharp),
                        errorText: 'Please enter your province',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: careerController,
                        labelText: MTexts.career,
                        prefixIcon: const Icon(Icons.work),
                        errorText: 'Please enter your career',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: nationalityController,
                        labelText: MTexts.nationality,
                        prefixIcon: const Icon(Icons.flag),
                        errorText: 'Please enter your nationality',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      Text(
                        MTexts.loginPassword,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Gap(MSize.defaultSpace),
                      CustomTextFormField(
                        controller: usernameController,
                        labelText: MTexts.phoneNumber,
                        prefixIcon: const Icon(Icons.phone),
                        errorText: 'Please enter your phone number',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      PasswordMatch(
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                      ),
                      const Gap(MSize.spaceBtwSections),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _validateImages()) {
                              final address = AddressModel(
                                village: villageController.text,
                                district: districtController.text,
                                province: provinceController.text,
                              );
                              final jobHunter = JobHunterModel(
                                username: usernameController.text,
                                password: passwordController.text,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                gender: gender,
                                idCardImage: idCardImageController.file!.path,
                                selfImageIdCard: selfImageController.file!.path,
                                birthDate: birthDateController.text,
                                address: address,
                                career: careerController.text,
                                nationality: nationalityController.text,
                              );
                              context
                                  .read<AuthBloc>()
                                  .add(SignupJobHunterEvent(jobHunter));
                            } else {
                              setState(() {});
                            }
                          },
                          child: const Text(MTexts.signUp),
                        ),
                      ),
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
