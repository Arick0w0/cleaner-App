import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/core/utils/show_snackbar.dart';
import 'package:mae_ban/core/widgets/loader.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/text_form_field.dart';
import 'otp_screen.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ລືມລະຫັດຜ່ານ'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordOtpSent) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                    phoneNumber: "20" + _phoneController.text,
                    bearerToken: state.bearerToken),
              ),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // TextField(
                //   controller: _phoneController,
                //   decoration: InputDecoration(
                //     labelText: 'Phone Number',
                //     border: OutlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.phone,
                // ),
                SizedBox(
                  height: 200,
                  child: Image.asset(MTexts.person),
                ),
                Text(
                  'ກູ້ຄືນລະຫັດຜ່ານ',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: MColors.black),
                ),
                Gap(25),
                CustomTextFormField(
                  controller: _phoneController,
                  labelText: MTexts.phoneNumber,
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                  errorText: MTexts.pleaseenteryourphonenumber,
                  useMaxLength: true,
                  usePrefix: true, // Show prefix
                ),
                const Gap(20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final phoneNumber = '20' + _phoneController.text;
                      if (phoneNumber.isNotEmpty) {
                        context.read<AuthBloc>().add(SendOtpEvent(phoneNumber));
                      } else {
                        showSnackBar(
                          context,
                          MTexts.plsselectimage,
                          backgroundColor: Colors.orange,
                        );
                      }
                    },
                    child: const Text('Send OTP'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
