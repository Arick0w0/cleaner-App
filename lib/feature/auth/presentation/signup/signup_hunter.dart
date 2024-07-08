import 'dart:convert'; // Add this import for jsonEncode
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/core/utils/show_snackbar.dart';
import 'package:mae_ban/core/widgets/loader.dart';
import 'package:mae_ban/feature/auth/data/models/address_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/obscure_text_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/gender_selection_widget.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/image_picker_widget.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/password_match.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/text_form_field.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/shared/data/services/api_service.dart';
import 'package:mae_ban/feature/shared/presentation/view/area_selector_view.dart';
import 'package:mae_ban/feature/shared/presentation/view/province_selector_view.dart';
import 'package:mae_ban/feature/shared/presentation/view/service_type_selector_view.dart';
import 'package:mae_ban/service_locator.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_event.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_bloc.dart';

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
  final TextEditingController serviceTypeController = TextEditingController();

  String gender = 'MALE';
  final ImagePickerController idCardController = ImagePickerController();
  final ImagePickerController photoIdController = ImagePickerController();

  @override
  void initState() {
    super.initState();

    // Add listeners to controllers
    //   usernameController
    //       .addListener(() => print('Username: ${usernameController.text}'));
    //   passwordController
    //       .addListener(() => print('Password: ${passwordController.text}'));
    //   firstNameController
    //       .addListener(() => print('First Name: ${firstNameController.text}'));
    //   lastNameController
    //       .addListener(() => print('Last Name: ${lastNameController.text}'));
    //   confirmPasswordController.addListener(
    //       () => print('Confirm Password: ${confirmPasswordController.text}'));
    //   birthDateController
    //       .addListener(() => print('Birth Date: ${birthDateController.text}'));
    //   villageController
    //       .addListener(() => print('Village: ${villageController.text}'));
    //   districtController
    //       .addListener(() => print('District: ${districtController.text}'));
    //   provinceController
    //       .addListener(() => print('Province: ${provinceController.text}'));
    //   careerController
    //       .addListener(() => print('Career: ${careerController.text}'));
    //   nationalityController
    //       .addListener(() => print('Nationality: ${nationalityController.text}'));
    //   serviceTypeController.addListener(
    //       () => print('Service Type: ${serviceTypeController.text}'));
  }

  @override
  void dispose() {
    // Dispose controllers
    usernameController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();
    birthDateController.dispose();
    villageController.dispose();
    districtController.dispose();
    provinceController.dispose();
    careerController.dispose();
    nationalityController.dispose();
    serviceTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DataBloc(apiService: sl<ApiServiceGet>())..add(FetchData()),
        ),
        BlocProvider(create: (context) => SelectionBloc()),
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
            context.go(
              '/login',
              extra: {
                'username': usernameController.text,
                'status': 'REGISTERED'
              },
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text(MTexts.signUpHunter),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: MSize.spaceBtwSections,
                  horizontal: 14,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
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
                            controller: idCardController,
                          ),
                          const Gap(MSize.spaceBtwItems),
                          Text(
                            MTexts.idCard,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const Gap(MSize.spaceBtwItems),
                          ImagePickerWidget(
                            controller: photoIdController,
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
                            keyboardType: TextInputType.phone,
                            enableDatePicker:
                                true, // enable for format yyyy-mm-dd
                          ),
                          const Gap(MSize.spaceBtwItems),
                          ProvinceSelectorView(
                            provinceController: provinceController,
                          ),
                          const Gap(MSize.spaceBtwItems),
                          AreaSelectorView(
                            areaController: districtController,
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
                            controller: careerController,
                            labelText: MTexts.career,
                            prefixIcon: const Icon(Icons.work),
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
                            'ເລືອກປະເພດບໍລິການ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const Gap(MSize.spaceBtwItems),
                          ServiceTypeSelectorView(
                            serviceTypeController: serviceTypeController,
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
                            keyboardType: TextInputType.phone,
                            usePrefix:
                                true, // Show prefix // Set the prefix to 020
                            useMaxLength: true,
                            errorText: MTexts.pleaseenteryourphonenumber,
                          ),
                          const Gap(MSize.spaceBtwItems),
                          PasswordMatch(
                            passwordController: passwordController,
                            confirmPasswordController:
                                confirmPasswordController,
                          ),
                          const Gap(MSize.spaceBtwSections),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    idCardController.file != null &&
                                    photoIdController.file != null) {
                                  final gender = context
                                      .read<GenderSelectionCubit>()
                                      .state;
                                  final usernameWithPrefix =
                                      '20${usernameController.text}';
                                  final address = Address(
                                    village: villageController.text,
                                    district: districtController.text,
                                    province: provinceController.text,
                                    addressName: '',
                                    googleMap: '',
                                  );

                                  final selectedServiceTypes = context
                                      .read<SelectionBloc>()
                                      .state
                                      .selectedServiceTypes;

                                  final jobHunter = JobHunterModel(
                                    username: usernameWithPrefix,
                                    password: passwordController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    birthDate: birthDateController.text,
                                    address: [
                                      address
                                    ], // ทำให้เป็น List<AddressModel>
                                    career: careerController.text,
                                    nationality: nationalityController.text,
                                    gender: gender,
                                    idCardImage:
                                        Uri.file(idCardController.file!.path)
                                            .pathSegments
                                            .last,
                                    selfImageIdCard:
                                        Uri.file(photoIdController.file!.path)
                                            .pathSegments
                                            .last,
                                    serviceTypes: selectedServiceTypes,
                                  );

                                  print(
                                      'JobHunter data: ${jsonEncode(jobHunter.toJson())}');

                                  context
                                      .read<AuthBloc>()
                                      .add(SignupJobHunterEvent(jobHunter));
                                } else {
                                  showSnackBar(
                                    context,
                                    MTexts.plsselectimage,
                                    backgroundColor: Colors.orange,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
