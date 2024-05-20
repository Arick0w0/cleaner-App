import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/core/utils/show_snackbar.dart';
import 'package:mae_ban/core/widgets/loader.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/obscure_text_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/gender_selection_widget.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/image_picker_widget.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/password_match.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
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

  String gender = 'MALE';
  final ImagePickerController idCardController = ImagePickerController();
  final ImagePickerController photoIdController = ImagePickerController();

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
              backgroundColor: Colors.red,
            );
          } else if (state is AuthSuccess) {
            showSnackBar(context, MTexts.signUpSuccess,
                backgroundColor: Colors.green);
            context.go('/home-job-hunter');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Loader();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(MTexts.signUpHunter),
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
                        MTexts.photoAndId,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      ImagePickerWidget(
                        // title: 'Tap to select ID Card Image',
                        controller: idCardController,
                        // backgroundColor: MColors.primary,
                        // errorText: 'Please select an ID Card Image',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      Text(
                        MTexts.idCard,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      ImagePickerWidget(
                        // title: 'Tap to select Photo ID',
                        controller: photoIdController,
                        // backgroundColor: MColors.primary,
                        // errorText: 'Please select a Photo ID',
                      ),
                      const Gap(MSize.spaceBtwItems),
                      const GenderSelectionWidget(),
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
                      CustomTextFormField(
                        controller: birthDateController,
                        labelText: MTexts.date,
                        prefixIcon: const Icon(Icons.calendar_today),
                        errorText: MTexts.pleaseenteryourbirthday,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: villageController,
                        labelText: MTexts.village,
                        prefixIcon: const Icon(Icons.home),
                        errorText: MTexts.pleaseenteryourvillage,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: districtController,
                        labelText: MTexts.district,
                        prefixIcon: const Icon(Icons.location_city),
                        errorText: MTexts.pleaseenteryourdistrict,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: provinceController,
                        labelText: MTexts.province,
                        prefixIcon: const Icon(Icons.location_city_sharp),
                        errorText: MTexts.pleaseenteryourprovince,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: careerController,
                        labelText: MTexts.career,
                        prefixIcon: const Icon(Icons.person),
                        errorText: MTexts.pleaseenteryourcareer,
                      ),
                      const Gap(MSize.spaceBtwItems),
                      CustomTextFormField(
                        controller: nationalityController,
                        labelText: MTexts.nationality,
                        prefixIcon: const Icon(Icons.flag),
                        errorText: MTexts.pleaseenteryournationality,
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
                        errorText: MTexts.pleaseenteryourphonenumber,
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
                                idCardController.file != null &&
                                photoIdController.file != null) {
                              final gender =
                                  context.read<GenderSelectionCubit>().state;
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
                                birthDate: birthDateController.text,
                                address: address,
                                career: careerController.text,
                                nationality: nationalityController.text,
                                gender: gender,
                                idCardImage: idCardController.file!.path,
                                selfImageIdCard: photoIdController.file!.path,
                              );

                              print('JobHunter data: $jobHunter');

                              context
                                  .read<AuthBloc>()
                                  .add(SignupJobHunterEvent(jobHunter));
                            } else {
                              showSnackBar(
                                context,
                                MTexts.plsselectimage,
                                backgroundColor:
                                    const Color.fromARGB(255, 226, 186, 86),
                              );
                            }
                          },
                          child: const Text(MTexts.signUp),
                        ),
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
